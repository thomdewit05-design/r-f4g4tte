import GameKit
import UIKit

/// Zoekt het bovenste scherm, zodat we er iets (deelmenu, Game Center) overheen kunnen tonen.
enum Presenter {
    static func top() -> UIViewController? {
        let scenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
        let scene = scenes.first { $0.activationState == .foregroundActive } ?? scenes.first
        var vc = scene?.windows.first { $0.isKeyWindow }?.rootViewController ?? scene?.windows.first?.rootViewController
        while let next = vc?.presentedViewController { vc = next }
        return vc
    }
}

/// Game Center: inloggen, scores insturen en de ranglijst tonen.
/// Maak in App Store Connect een ranglijst aan met precies dit ID.
final class GameCenter {
    static let shared = GameCenter()
    static let leaderboardID = "snacktrip.highscore"
    private var showWhenReady = false

    func authenticate() {
        GKLocalPlayer.local.authenticateHandler = { [weak self] viewController, _ in
            if let viewController {
                Presenter.top()?.present(viewController, animated: true)
            } else if GKLocalPlayer.local.isAuthenticated, self?.showWhenReady == true {
                self?.showWhenReady = false
                self?.showLeaderboard()
            }
        }
    }

    func submit(score: Int) {
        guard GKLocalPlayer.local.isAuthenticated, score > 0 else { return }
        GKLeaderboard.submitScore(score, context: 0, player: GKLocalPlayer.local,
                                  leaderboardIDs: [Self.leaderboardID]) { _ in }
    }

    func showLeaderboard() {
        guard GKLocalPlayer.local.isAuthenticated else {
            showWhenReady = true
            authenticate()
            return
        }
        GKAccessPoint.shared.trigger(state: .leaderboards) {}
    }
}

/// iCloud: bewaart de voortgang (record, spaarpot, karakters, opdrachten) op al je apparaten.
/// Zonder iCloud-rechten werkt het gewoon lokaal; er gaat niets mis.
enum CloudSave {
    private static let key = "save"

    /// JavaScript dat de laatste cloud-voortgang klaarzet vóórdat het spel start.
    static func bootstrapScript() -> String {
        let store = NSUbiquitousKeyValueStore.default
        store.synchronize()
        guard let json = store.string(forKey: key),
              let data = json.data(using: .utf8),
              (try? JSONSerialization.jsonObject(with: data)) is [String: Any]
        else { return "" }
        return "window.__cloudSave = \(json);"
    }

    static func save(_ json: String) {
        guard json.utf8.count < 900_000 else { return } // ruim binnen de iCloud-limiet
        let store = NSUbiquitousKeyValueStore.default
        store.set(json, forKey: key)
        store.synchronize()
    }
}

/// Het deelmenu van iOS met de score-afbeelding en tekst.
enum Share {
    static func present(text: String, imageDataURL: String?) {
        var items: [Any] = []
        if let imageDataURL,
           let comma = imageDataURL.firstIndex(of: ","),
           let data = Data(base64Encoded: String(imageDataURL[imageDataURL.index(after: comma)...])),
           let image = UIImage(data: data) {
            items.append(image)
        }
        items.append(text)
        guard let top = Presenter.top() else { return }
        let sheet = UIActivityViewController(activityItems: items, applicationActivities: nil)
        if let popover = sheet.popoverPresentationController { // iPad
            popover.sourceView = top.view
            popover.sourceRect = CGRect(x: top.view.bounds.midX, y: top.view.bounds.midY, width: 1, height: 1)
            popover.permittedArrowDirections = []
        }
        top.present(sheet, animated: true)
    }
}
