import Foundation

public struct Business: Codable {
    public let id: String
    public let name: String
    public let location: String

    public init(id: String, name: String, location: String) {
        self.id = id
        self.name = name
        self.location = location
    }
}
