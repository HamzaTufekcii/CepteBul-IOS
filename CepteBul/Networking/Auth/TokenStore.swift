import Foundation

actor TokenStore {
    private var accessToken: String?
    private var refreshToken: String?
    
    func getAccessToken() -> String? {
        accessToken
    }
    
    func setAccessToken(_ token: String?) {
        accessToken = token
    }
    
    func getRefreshToken() -> String? {
        refreshToken
    }
    
    func setRefreshToken(_ token: String?) {
        refreshToken = token
    }
    
    func set(tokens: AuthTokenResponse) {
        accessToken = tokens.accessToken
        refreshToken = tokens.refreshToken
    }
}
