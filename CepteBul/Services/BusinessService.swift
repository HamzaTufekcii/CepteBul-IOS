import Foundation

final class BusinessService {
    private let client: APIClient
    
    init(client: APIClient) {
        self.client = client
    }
    
    func listBusinesses() async throws -> [Business] {
        try await client.request(.listBusinesses(), body: nil)
    }
}
