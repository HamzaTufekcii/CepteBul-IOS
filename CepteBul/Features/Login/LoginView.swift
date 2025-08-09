import SwiftUI
import Foundation

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @Binding var email: String
    @State private var password: String = ""
    @State private var showError: Bool = false

    var body: some View {
        VStack(spacing: 16) {
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            if showError {
                Text("Lütfen geçerli bir e-posta giriniz.")
                    .foregroundColor(.red)
            }
            Button("Giriş Yap") {
                if isValidEmail(email) {
                    showError = false
                    isLoggedIn = true
                } else {
                    showError = true
                }
            }
        }
        .padding()
    }

    private func isValidEmail(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
}

#Preview {
    LoginView(isLoggedIn: .constant(false), email: .constant(""))
}
