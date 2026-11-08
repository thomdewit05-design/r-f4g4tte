import SwiftUI

/// Snack Trip! als native iOS-app.
/// Het spel zelf is `index.html` uit de hoofdmap van de repository; die wordt
/// in de app meegebundeld en offline geladen in een WKWebView.
@main
struct SnackTripApp: App {
    var body: some Scene {
        WindowGroup {
            GameWebView()
                .ignoresSafeArea()                // het spel regelt zelf de notch / Dynamic Island
                .statusBarHidden(true)
                .persistentSystemOverlays(.hidden) // home-indicator zo veel mogelijk verbergen
                .background(Color(red: 0.17, green: 0.10, blue: 0.05))
        }
    }
}
