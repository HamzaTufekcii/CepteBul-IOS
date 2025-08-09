import SwiftUI

struct HomeView: View {
    private let tokenStore: TokenStore

    init(tokenStore: TokenStore) {
        self.tokenStore = tokenStore
    }

    var body: some View {
        TabView {
            Text("Keşfet")
                .tabItem { Label("Keşfet", systemImage: "magnifyingglass") }

            NavigationStack {
                BusinessListView(
                    viewModel: BusinessListViewModel(
                        service: BusinessService(client: APIClient(tokenStore: tokenStore))
                    )
                )
            }
            .tabItem { Label("Ana Sayfa", systemImage: "house") }

            Text("Profil")
                .tabItem { Label("Profil", systemImage: "person") }
        }
    }
}

#Preview {
    HomeView(tokenStore: TokenStore())
}
