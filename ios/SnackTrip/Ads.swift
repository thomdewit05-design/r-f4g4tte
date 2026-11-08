import AppTrackingTransparency
import GoogleMobileAds
import UIKit
import UserMessagingPlatform

/// Reclame via Google AdMob: een tussendoor-reclame na het doodgaan en een
/// beloonde reclame om verder te spelen. Het spel (JavaScript) vraagt erom via
/// de "ads"-brug; het resultaat gaat terug via window.__adResult(actie, gelukt).
///
/// LET OP: hieronder staan de testadvertenties van Google. Vervang ze door je
/// eigen ID's uit AdMob voordat je de app in de App Store zet (en ook de
/// GADApplicationIdentifier in Info.plist). Zie appstore/README.md.
final class Ads: NSObject, FullScreenContentDelegate {
    static let shared = Ads()
    static let interstitialUnitID = "ca-app-pub-3940256099942544/4411468910" // test
    static let rewardedUnitID = "ca-app-pub-3940256099942544/1712485313"     // test

    private var interstitial: InterstitialAd?
    private var rewarded: RewardedAd?
    private var started = false
    private var pending: ((Bool) -> Void)?
    private var earnedReward = false

    /// Eerst toestemming vragen (AVG, via Google UMP), dan App Tracking Transparency, dan pas reclame laden.
    func start() {
        ConsentInformation.shared.requestConsentInfoUpdate(with: RequestParameters()) { [weak self] _ in
            DispatchQueue.main.async {
                guard let self else { return }
                guard let top = Presenter.top() else { self.requestTracking(); return }
                ConsentForm.loadAndPresentIfRequired(from: top) { [weak self] _ in
                    DispatchQueue.main.async { self?.requestTracking() }
                }
            }
        }
    }

    private func requestTracking() {
        ATTrackingManager.requestTrackingAuthorization { [weak self] _ in
            DispatchQueue.main.async { self?.startSDK() }
        }
    }

    private func startSDK() {
        guard !started, ConsentInformation.shared.canRequestAds else { return }
        started = true
        MobileAds.shared.requestConfiguration.maxAdContentRating = .general // alleen reclame voor alle leeftijden
        MobileAds.shared.start(completionHandler: nil)
        loadInterstitial()
        loadRewarded()
    }

    private func loadInterstitial() {
        InterstitialAd.load(with: Self.interstitialUnitID, request: Request()) { [weak self] ad, _ in
            ad?.fullScreenContentDelegate = self
            self?.interstitial = ad
        }
    }

    private func loadRewarded() {
        RewardedAd.load(with: Self.rewardedUnitID, request: Request()) { [weak self] ad, _ in
            ad?.fullScreenContentDelegate = self
            self?.rewarded = ad
        }
    }

    /// Toont een tussendoor-reclame. done(false) als er geen klaarstaat (het spel toont dan een eigen promo).
    func showInterstitial(done: @escaping (Bool) -> Void) {
        guard let ad = interstitial, let top = Presenter.top() else { done(false); if started { loadInterstitial() }; return }
        interstitial = nil
        pending = done
        ad.present(from: top)
    }

    /// Toont een beloonde reclame. done(true) alleen als de beloning verdiend is.
    func showRewarded(done: @escaping (Bool) -> Void) {
        guard let ad = rewarded, let top = Presenter.top() else { done(false); if started { loadRewarded() }; return }
        rewarded = nil
        earnedReward = false
        pending = done
        ad.present(from: top) { [weak self] in self?.earnedReward = true }
    }

    // MARK: FullScreenContentDelegate

    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        let wasRewarded = ad is RewardedAd
        finish(wasRewarded ? earnedReward : true)
        if wasRewarded { loadRewarded() } else { loadInterstitial() }
    }

    func ad(_ ad: FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        finish(false)
        if ad is RewardedAd { loadRewarded() } else { loadInterstitial() }
    }

    private func finish(_ ok: Bool) {
        let callback = pending
        pending = nil
        DispatchQueue.main.async { callback?(ok) }
    }
}
