import Foundation

struct AuthTokenResponse: Codable {
    let accessToken: String
    let refreshToken: String
}
