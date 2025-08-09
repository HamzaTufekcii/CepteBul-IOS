import SwiftUI

struct ProfileView: View {
    let email: String

    var body: some View {
        Text("Giriş Yapılan e-posta: \(email)")
            .font(.body)
            .padding()
    }
}

#Preview {
    ProfileView(email: "example@example.com")
}
