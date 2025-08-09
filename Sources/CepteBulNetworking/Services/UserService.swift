import Foundation

public final class UserService {
    private let client: APIClient

    public init(client: APIClient) {
        self.client = client
    }

    public func updateUser(id: String, body: UserUpdateRequest) async throws -> UserResponse {
        try await client.request(.updateUser(id: id), body: body)
    }
}
