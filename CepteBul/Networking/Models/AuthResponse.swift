import Foundation

struct AuthResponse: Codable {
    let user: UserResponse
    let token: AuthTokenResponse
}
