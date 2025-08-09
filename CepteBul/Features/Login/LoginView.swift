import SwiftUI

/// A simple login screen that authenticates the user against the backend.
/// On success the returned tokens are persisted using `TokenStore` and the
/// `isLoggedIn` flag is toggled so parent views can react to the login state.
struct LoginView: View {
    // MARK: - State
    @State private var email = ""
    @State private var password = ""
    @State private var error: String?
    @State private var isLoggedIn = false

    // MARK: - Dependencies
    private let tokenStore: TokenStore
    private let authService: AuthService

    init() {
        let tokenStore = TokenStore()
        self.tokenStore = tokenStore
        self.authService = AuthService(client: APIClient(), tokenStore: tokenStore)
    }

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)

            if let error {
                Text(error).foregroundColor(.red)
            }

            Button("Giriş Yap") {
                Task { await login() }
            }

            if isLoggedIn {
                Text("Başarıyla giriş yapıldı")
                    .foregroundColor(.green)
            }
        }
        .padding()
    }

    /// Performs the login request and handles storing tokens or errors.
    private func login() async {
        do {
            let req = AuthRequest(email: email, password: password)
            let response = try await authService.login(req)
            // Persist tokens for later authenticated requests
            await tokenStore.set(tokens: response.token)
            isLoggedIn = true
        } catch {
            if let apiError = error as? APIError {
                self.error = apiError.message
            } else {
                self.error = error.localizedDescription
            }
        }
    }
}

#Preview {
    LoginView()
}

