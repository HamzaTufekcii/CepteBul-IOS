import Foundation

public struct UserResponse: Codable {
    public let id: String
    public let email: String
    public let name: String
    public let surname: String
    public let phoneNumber: String

    public init(id: String, email: String, name: String, surname: String, phoneNumber: String) {
        self.id = id
        self.email = email
        self.name = name
        self.surname = surname
        self.phoneNumber = phoneNumber
    }
}
