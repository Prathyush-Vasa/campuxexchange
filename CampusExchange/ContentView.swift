import SwiftUI

struct ContentView: View {
    @StateObject private var appState = AppState()
    
    var body: some View {
        Group {
            if appState.isLoggedIn {
                MainTabView()
                    .environmentObject(appState)
            } else {
                AuthenticationView()
                    .environmentObject(appState)
            }
        }
    }
}

struct MainTabView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        TabView {
            MarketplaceView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            MessagesListView()
                .tabItem {
                    Label("Messages", systemImage: "message.fill")
                }
            
            AddItemView()
                .tabItem {
                    Label("Sell", systemImage: "plus.circle.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .accentColor(Color("ASUMaroon"))
    }
}

#Preview {
    ContentView()
}
