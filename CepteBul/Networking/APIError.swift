import Foundation

struct APIError: Error, LocalizedError {
    let code: Int?
    let message: String
    let details: String?
    
    var errorDescription: String? {
        message
    }
}
