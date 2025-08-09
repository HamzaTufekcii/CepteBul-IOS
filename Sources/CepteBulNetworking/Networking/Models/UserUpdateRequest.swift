import Foundation

public struct UserUpdateRequest: Codable {
    public let email: String?
    public let name: String?
    public let surname: String?
    public let phoneNumber: String?

    public init(email: String?, name: String?, surname: String?, phoneNumber: String?) {
        self.email = email
        self.name = name
        self.surname = surname
        self.phoneNumber = phoneNumber
    }
}
