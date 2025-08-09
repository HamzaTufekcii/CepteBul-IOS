import Foundation

final class AuthService {
    private let client: APIClient
    private let tokenStore: TokenStore
    
    init(client: APIClient, tokenStore: TokenStore) {
        self.client = client
        self.tokenStore = tokenStore
    }
    
    func register(_ req: AuthRequest) async throws -> APIResponse {
        try await client.request(.register(), body: req)
    }
    
    func login(_ req: AuthRequest) async throws -> AuthResponse {
        let response: AuthResponse = try await client.request(.login(), body: req)
        await tokenStore.set(tokens: response.token)
        return response
    }
    
    func refresh(_ req: AuthRefreshTokenRequest) async throws -> AuthTokenResponse {
        let tokens: AuthTokenResponse = try await client.request(.refresh(), body: req)
        await tokenStore.set(tokens: tokens)
        return tokens
    }
}
