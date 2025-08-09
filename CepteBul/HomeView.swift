import SwiftUI
import CepteBulNetworking

struct HomeView: View {
    var body: some View {
        TabView {
            BusinessListView(
                viewModel: BusinessListViewModel(
                    service: BusinessService(client: APIClient())
                )
            )
            .tabItem {
                Label("Ana Sayfa", systemImage: "house")
            }

            Text("Keşfet")
                .tabItem {
                    Label("Keşfet", systemImage: "magnifyingglass")
                }

            Text("Profil")
                .tabItem {
                    Label("Profil", systemImage: "person")
                }
        }
    }
}

#Preview {
    HomeView()
}
