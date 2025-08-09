import Foundation

public final class BusinessService {
    private let client: APIClient

    public init(client: APIClient) {
        self.client = client
    }

    public func listBusinesses() async throws -> [Business] {
        try await client.request(.listBusinesses(), body: nil)
    }
}
