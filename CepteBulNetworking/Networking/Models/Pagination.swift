import Foundation

public struct Pagination: Codable {
    public let page: Int?
    public let size: Int?
    public let totalPages: Int?
    public let totalItems: Int?

    public init(page: Int?, size: Int?, totalPages: Int?, totalItems: Int?) {
        self.page = page
        self.size = size
        self.totalPages = totalPages
        self.totalItems = totalItems
    }
}
