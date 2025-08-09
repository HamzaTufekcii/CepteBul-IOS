import XCTest
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import CepteBulNetworking

final class APIClientTests: XCTestCase {
    var client: APIClient!
    var tokenStore: TokenStore!
    
    override func setUp() async throws {
        tokenStore = TokenStore()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        client = APIClient(baseURL: URL(string: "http://localhost:8080")!, tokenStore: tokenStore, session: session)
        MockURLProtocol.handlers = []
        MockURLProtocol.requestCount = 0
    }
    
    func testLoginSuccess() async throws {
        let response = AuthResponse(
            user: UserResponse(id: "1", email: "a@b.com", name: "A", surname: "B", phoneNumber: "123"),
            token: AuthTokenResponse(accessToken: "access", refreshToken: "refresh")
        )
        let data = try JSONEncoder().encode(response)
        MockURLProtocol.handlers = [ { request in
            let resp = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (resp, data)
        } ]
        let service = AuthService(client: client, tokenStore: tokenStore)
        let result = try await service.login(AuthRequest(email: "a@b.com", password: "pw"))
        XCTAssertEqual(result.user.email, "a@b.com")
        let stored = await tokenStore.getAccessToken()
        XCTAssertEqual(stored, "access")
        XCTAssertEqual(MockURLProtocol.requestCount, 1)
    }
    
    func test401RefreshRetry() async throws {
        await tokenStore.setAccessToken("old")
        await tokenStore.setRefreshToken("refresh")
        let businessData = try JSONEncoder().encode([Business(id: "1", name: "Biz", location: "Loc")])
        let tokenData = try JSONEncoder().encode(AuthTokenResponse(accessToken: "new", refreshToken: "newR"))
        MockURLProtocol.handlers = [
            { req in
                let resp = HTTPURLResponse(url: req.url!, statusCode: 401, httpVersion: nil, headerFields: nil)!
                return (resp, Data())
            },
            { req in
                let resp = HTTPURLResponse(url: req.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (resp, tokenData)
            },
            { req in
                let resp = HTTPURLResponse(url: req.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (resp, businessData)
            }
        ]
        let businesses: [Business] = try await client.request(.listBusinesses(), body: nil)
        XCTAssertEqual(businesses.count, 1)
        XCTAssertEqual(MockURLProtocol.requestCount, 3)
        let stored = await tokenStore.getAccessToken()
        XCTAssertEqual(stored, "new")
    }
    
    func test429BackoffRetries() async throws {
        let businessData = try JSONEncoder().encode([Business(id: "1", name: "Biz", location: "Loc")])
        MockURLProtocol.handlers = [
            { req in
                let resp = HTTPURLResponse(url: req.url!, statusCode: 429, httpVersion: nil, headerFields: nil)!
                return (resp, Data())
            },
            { req in
                let resp = HTTPURLResponse(url: req.url!, statusCode: 429, httpVersion: nil, headerFields: nil)!
                return (resp, Data())
            },
            { req in
                let resp = HTTPURLResponse(url: req.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (resp, businessData)
            }
        ]
        let businesses: [Business] = try await client.request(.listBusinesses(), body: nil)
        XCTAssertEqual(businesses.count, 1)
        XCTAssertEqual(MockURLProtocol.requestCount, 3)
    }
    
    func testDecodeError() async throws {
        MockURLProtocol.handlers = [ { req in
            let resp = HTTPURLResponse(url: req.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (resp, Data("not json".utf8))
        } ]
        do {
            let _: [Business] = try await client.request(.listBusinesses(), body: nil)
            XCTFail("Expected decoding error")
        } catch let error as APIError {
            XCTAssertEqual(error.message, "Decoding error")
        }
    }
}
