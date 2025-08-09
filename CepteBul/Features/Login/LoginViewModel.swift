import Foundation
import SwiftUI

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var error: String?
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func login() async {
        do {
            let req = AuthRequest(email: email, password: password)
            _ = try await authService.login(req)
        } catch {
            if let apiError = error as? APIError {
                self.error = apiError.message
            } else {
                self.error = error.localizedDescription
            }
        }
    }
}
