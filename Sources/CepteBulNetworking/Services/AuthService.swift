import Foundation

public final class AuthService {
    private let client: APIClient
    private let tokenStore: TokenStore

    public init(client: APIClient, tokenStore: TokenStore) {
        self.client = client
        self.tokenStore = tokenStore
    }

    public func register(_ req: AuthRequest) async throws -> APIResponse {
        try await client.request(.register(), body: req)
    }

    public func login(_ req: AuthRequest) async throws -> AuthResponse {
        let response: AuthResponse = try await client.request(.login(), body: req)
        await tokenStore.set(tokens: response.token)
        return response
    }

    public func refresh(_ req: AuthRefreshTokenRequest) async throws -> AuthTokenResponse {
        let tokens: AuthTokenResponse = try await client.request(.refresh(), body: req)
        await tokenStore.set(tokens: tokens)
        return tokens
    }
}
