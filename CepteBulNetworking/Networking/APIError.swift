import Foundation

public struct APIError: Error, LocalizedError {
    public let code: Int?
    public let message: String
    public let details: String?

    public init(code: Int?, message: String, details: String?) {
        self.code = code
        self.message = message
        self.details = details
    }

    public var errorDescription: String? {
        message
    }
}
