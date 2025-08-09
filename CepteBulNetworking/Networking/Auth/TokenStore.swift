import Foundation

public actor TokenStore {
    private var accessToken: String?
    private var refreshToken: String?

    public init() {}

    public func getAccessToken() -> String? {
        accessToken
    }

    public func setAccessToken(_ token: String?) {
        accessToken = token
    }

    public func getRefreshToken() -> String? {
        refreshToken
    }

    public func setRefreshToken(_ token: String?) {
        refreshToken = token
    }

    public func set(tokens: AuthTokenResponse) {
        accessToken = tokens.accessToken
       refreshToken = tokens.refreshToken
    }
}
