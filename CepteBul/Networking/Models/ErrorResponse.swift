import Foundation

struct ErrorResponse: Codable {
    let code: Int
    let message: String
    let details: String?
}
