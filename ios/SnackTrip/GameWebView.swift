import SwiftUI
import UIKit
import WebKit

/// Toont het HTML-spel fullscreen en verbindt het met iOS:
/// trillen, Game Center, iCloud-opslag, het deelmenu en reclame (AdMob).
struct GameWebView: UIViewRepresentable {
    private static let background = UIColor(red: 0.17, green: 0.10, blue: 0.05, alpha: 1)
    private static let handlers = ["haptic", "cloud", "share", "gamecenter", "ads"]

    func makeCoordinator() -> Coordinator { Coordinator() }

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        config.websiteDataStore = .default() // lokale opslag (localStorage) blijft bewaard

        let controller = config.userContentController
        for name in Self.handlers { controller.add(context.coordinator, name: name) }
        let bootstrap = CloudSave.bootstrapScript()
        if !bootstrap.isEmpty {
            controller.addUserScript(WKUserScript(source: bootstrap, injectionTime: .atDocumentStart, forMainFrameOnly: true))
        }

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.isOpaque = false
        webView.backgroundColor = Self.background
        webView.scrollView.backgroundColor = Self.background
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.scrollView.pinchGestureRecognizer?.isEnabled = false
        webView.allowsLinkPreview = false
        #if DEBUG
        webView.isInspectable = true // debuggen via Safari > Ontwikkel
        #endif

        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
            webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
        context.coordinator.webView = webView
        GameCenter.shared.authenticate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { Ads.shared.start() } // na het opstarten: toestemming + reclame laden
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    static func dismantleUIView(_ uiView: WKWebView, coordinator: Coordinator) {
        for name in handlers { uiView.configuration.userContentController.removeScriptMessageHandler(forName: name) }
    }

    @MainActor
    final class Coordinator: NSObject, WKScriptMessageHandler {
        weak var webView: WKWebView?
        private let light = UIImpactFeedbackGenerator(style: .light)
        private let notification = UINotificationFeedbackGenerator()

        func userContentController(_ userContentController: WKUserContentController,
                                   didReceive message: WKScriptMessage) {
            switch message.name {
            case "haptic":
                switch message.body as? String {
                case "light":   light.impactOccurred(intensity: 0.6)
                case "success": notification.notificationOccurred(.success)
                case "warning": notification.notificationOccurred(.warning)
                case "error":   notification.notificationOccurred(.error)
                default:        break
                }
            case "cloud":
                if let json = message.body as? String { CloudSave.save(json) }
            case "share":
                let body = message.body as? [String: Any] ?? [:]
                Share.present(text: body["text"] as? String ?? "Snack Trip!", imageDataURL: body["image"] as? String)
            case "gamecenter":
                let body = message.body as? [String: Any] ?? [:]
                if body["action"] as? String == "show" {
                    GameCenter.shared.showLeaderboard()
                } else if let score = body["score"] as? Int {
                    GameCenter.shared.submit(score: score)
                } else if let score = body["score"] as? Double {
                    GameCenter.shared.submit(score: Int(score))
                }
            case "ads":
                let body = message.body as? [String: Any] ?? [:]
                let action = body["action"] as? String ?? ""
                let reply: (Bool) -> Void = { [weak self] ok in
                    self?.webView?.evaluateJavaScript("window.__adResult && window.__adResult('\(action)', \(ok))")
                }
                if action == "rewarded" { Ads.shared.showRewarded(done: reply) }
                else if action == "interstitial" { Ads.shared.showInterstitial(done: reply) }
            default:
                break
            }
        }
    }
}
