import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
            if let error = viewModel.error {
                Text(error).foregroundColor(.red)
            }
            Button("Login") {
                Task { await viewModel.login() }
            }
        }
        .padding()
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel(authService: AuthService(client: APIClient(), tokenStore: TokenStore())))
}
