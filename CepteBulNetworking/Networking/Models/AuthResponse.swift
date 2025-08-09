import Foundation

public struct AuthResponse: Codable {
    public let user: UserResponse
    public let token: AuthTokenResponse

    public init(user: UserResponse, token: AuthTokenResponse) {
        self.user = user
        self.token = token
    }
}
