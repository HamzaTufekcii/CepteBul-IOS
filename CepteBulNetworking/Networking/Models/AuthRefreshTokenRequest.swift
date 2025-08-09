import Foundation

public struct AuthRefreshTokenRequest: Codable {
    public let refreshToken: String

    public init(refreshToken: String) {
        self.refreshToken = refreshToken
    }
}
