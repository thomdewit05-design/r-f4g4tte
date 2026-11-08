import SwiftUI
import UIKit
import WebKit

/// Toont het HTML-spel fullscreen en vertaalt `haptic`-berichten uit JavaScript
/// naar trillingen (Taptic Engine).
struct GameWebView: UIViewRepresentable {
    private static let background = UIColor(red: 0.17, green: 0.10, blue: 0.05, alpha: 1)

    func makeCoordinator() -> Coordinator { Coordinator() }

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        config.websiteDataStore = .default() // bewaart record, spaarpot en karakters (localStorage)
        config.userContentController.add(context.coordinator, name: "haptic")

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
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    static func dismantleUIView(_ uiView: WKWebView, coordinator: Coordinator) {
        uiView.configuration.userContentController.removeScriptMessageHandler(forName: "haptic")
    }

    @MainActor
    final class Coordinator: NSObject, WKScriptMessageHandler {
        private let light = UIImpactFeedbackGenerator(style: .light)
        private let notification = UINotificationFeedbackGenerator()

        func userContentController(_ userContentController: WKUserContentController,
                                   didReceive message: WKScriptMessage) {
            switch message.body as? String {
            case "light":   light.impactOccurred(intensity: 0.6)
            case "success": notification.notificationOccurred(.success)
            case "warning": notification.notificationOccurred(.warning)
            case "error":   notification.notificationOccurred(.error)
            default:        break
            }
        }
    }
}
