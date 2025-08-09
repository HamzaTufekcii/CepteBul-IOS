import Foundation

actor TokenStore {
    private let accessKey = "accessToken"
    private let refreshKey = "refreshToken"
    private let defaults = UserDefaults.standard

    private var accessToken: String?
    private var refreshToken: String?

    init() {
        accessToken = defaults.string(forKey: accessKey)
        refreshToken = defaults.string(forKey: refreshKey)
    }

    func getAccessToken() -> String? {
        accessToken
    }

    func setAccessToken(_ token: String?) {
        accessToken = token
        defaults.set(token, forKey: accessKey)
    }

    func getRefreshToken() -> String? {
        refreshToken
    }

    func setRefreshToken(_ token: String?) {
        refreshToken = token
        defaults.set(token, forKey: refreshKey)
    }

    func set(tokens: AuthTokenResponse) {
        setAccessToken(tokens.accessToken)
        setRefreshToken(tokens.refreshToken)
    }
}
