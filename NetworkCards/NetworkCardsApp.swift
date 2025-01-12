import SwiftUI
import FirebaseCore

@main
struct NetworkCardsApp: App {
    @StateObject private var authManager = AuthManager() // Use @StateObject for Observable classes


    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if let user = authManager.user {
               
                DeckLibrary()
                    .environmentObject(authManager)
            } else {
                
                LaunchScreen()
                    .environmentObject(authManager)
            }
        }
    }

}
