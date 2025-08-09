import Foundation

struct Pagination: Codable {
    let page: Int?
    let size: Int?
    let totalPages: Int?
    let totalItems: Int?
}
