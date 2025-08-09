import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class APIClient {
    private let baseURL: URL
    private let session: URLSession
    private let tokenStore: TokenStore
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    init(baseURL: URL = URL(string: "http://localhost:8080")!, tokenStore: TokenStore = TokenStore(), session: URLSession = .shared) {
        self.baseURL = baseURL
        self.tokenStore = tokenStore
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint, body: (any Encodable)? = nil) async throws -> T {
        try await perform(endpoint: endpoint, body: body, attempt: 0, didRefresh: false)
    }
    
    private func perform<T: Decodable>(endpoint: Endpoint, body: (any Encodable)?, attempt: Int, didRefresh: Bool) async throws -> T {
        let request = try await makeRequest(endpoint: endpoint, body: body ?? endpoint.body)
        do {
            let (data, response) = try await session.data(for: request)
            guard let http = response as? HTTPURLResponse else {
                throw APIError(code: nil, message: "Invalid response", details: nil)
            }
            if http.statusCode == 401, endpoint.requiresAuth, !didRefresh, endpoint.path != Endpoint.refresh().path {
                try await refreshToken()
                return try await perform(endpoint: endpoint, body: body, attempt: attempt, didRefresh: true)
            }
            if (http.statusCode == 429 || (500..<600).contains(http.statusCode)) && attempt < 3 {
                let delay = pow(2.0, Double(attempt)) * 0.5
                try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
                return try await perform(endpoint: endpoint, body: body, attempt: attempt + 1, didRefresh: didRefresh)
            }
            guard (200..<300).contains(http.statusCode) else {
                let apiErr = try? decoder.decode(ErrorResponse.self, from: data)
                throw APIError(code: http.statusCode, message: apiErr?.message ?? "HTTP \(http.statusCode)", details: apiErr?.details)
            }
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw APIError(code: http.statusCode, message: "Decoding error", details: error.localizedDescription)
            }
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError(code: nil, message: "Network error", details: error.localizedDescription)
        }
    }
    
    private func makeRequest(endpoint: Endpoint, body: (any Encodable)?) async throws -> URLRequest {
        var components = URLComponents(url: baseURL.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: false)!
        components.queryItems = endpoint.query
        guard let url = components.url else {
            throw APIError(code: nil, message: "Invalid URL", details: nil)
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.timeoutInterval = 30
        for (key, value) in endpoint.headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        if endpoint.requiresAuth, let token = await tokenStore.getAccessToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        let payload = body
        if let payload {
            request.httpBody = try encoder.encode(payload)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    private func refreshToken() async throws {
        guard let refresh = await tokenStore.getRefreshToken() else {
            throw APIError(code: 401, message: "Missing refresh token", details: nil)
        }
        let endpoint = Endpoint.refresh()
        let req = AuthRefreshTokenRequest(refreshToken: refresh)
        let tokens: AuthTokenResponse = try await perform(endpoint: endpoint, body: req, attempt: 0, didRefresh: true)
        await tokenStore.set(tokens: tokens)
    }
}//FETCH AT OROSPU ÇOCUĞU
