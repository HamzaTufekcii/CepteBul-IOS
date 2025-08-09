import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false
    private let tokenStore = TokenStore()

    var body: some View {
        Group {
            if isLoggedIn {
                HomeView(tokenStore: tokenStore)
            } else {
                LoginView(isLoggedIn: $isLoggedIn, tokenStore: tokenStore)
            }
        }
        .task {
            if await tokenStore.getAccessToken() != nil {
                isLoggedIn = true
            }
        }
    }
}

#Preview {
    ContentView()
}
