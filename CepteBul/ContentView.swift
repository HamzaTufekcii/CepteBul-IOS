import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false
    @State private var email = ""

    var body: some View {
        if isLoggedIn {
            MainTabView(email: email)
        } else {
            LoginView(isLoggedIn: $isLoggedIn, email: $email)
        }
    }
}

#Preview {
    ContentView()
}
