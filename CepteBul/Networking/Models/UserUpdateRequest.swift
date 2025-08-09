import Foundation

struct UserUpdateRequest: Codable {
    let email: String?
    let name: String?
    let surname: String?
    let phoneNumber: String?
}
