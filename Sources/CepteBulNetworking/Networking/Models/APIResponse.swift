import Foundation

public struct APIResponse: Codable {
    public let success: Bool
    public let message: String?

    public init(success: Bool, message: String?) {
        self.success = success
        self.message = message
    }
}
