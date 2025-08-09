import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

struct Endpoint {
    let path: String
    let method: HTTPMethod
    var headers: [String: String] = [:]
    var query: [URLQueryItem]? = nil
    var body: (any Encodable)? = nil
    var requiresAuth: Bool = true
}

extension Endpoint {
    static func register() -> Endpoint {
        Endpoint(path: "/api/auth/register", method: .post, requiresAuth: false)
    }
    
    static func login() -> Endpoint {
        Endpoint(path: "/api/auth/login", method: .post, requiresAuth: false)
    }
    
    static func refresh() -> Endpoint {
        Endpoint(path: "/api/auth/refresh", method: .post, requiresAuth: false)
    }
    
    static func listBusinesses() -> Endpoint {
        Endpoint(path: "/api/businesses", method: .get)
    }
    
    static func updateUser(id: String) -> Endpoint {
        Endpoint(path: "/api/user/\(id)/update", method: .put)
    }
}
