import SwiftUI

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showEmailError: Bool = false
    @State private var isLoggedIn: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Spacer()

                if showEmailError {
                    Text("Hatalı mail girdiniz!")
                        .foregroundColor(.red)
                        .font(.caption)
                        .transition(.move(edge: .top))
                }

                TextField("Mail", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)

                SecureField("Şifre", text: $password)
                    .textFieldStyle(.roundedBorder)

                Button("Giriş yap", action: handleLogin)
                    .buttonStyle(.borderedProminent)

                NavigationLink("", destination: HomeView(), isActive: $isLoggedIn)
                    .hidden()

                Spacer()
            }
            .padding()
        }
    }

    private func handleLogin() {
        if isValidEmail(email) && password.count >= 6 {
            isLoggedIn = true
        } else if !isValidEmail(email) {
            withAnimation { showEmailError = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation { showEmailError = false }
            }
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}

#Preview { ContentView() }
