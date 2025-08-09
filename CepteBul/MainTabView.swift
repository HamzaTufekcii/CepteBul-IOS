import SwiftUI

struct MainTabView: View {
    let email: String

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            SearchView()
                .tabItem {
                    Label("Ara", systemImage: "magnifyingglass")
                }
            ProfileView(email: email)
                .tabItem {
                    Label("Profil", systemImage: "person.crop.circle")
                }
        }
    }
}

#Preview {
    MainTabView(email: "example@example.com")
}
