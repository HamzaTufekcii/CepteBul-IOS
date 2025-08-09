import Foundation

final class UserService {
    private let client: APIClient
    
    init(client: APIClient) {
        self.client = client
    }
    
    func updateUser(id: String, body: UserUpdateRequest) async throws -> UserResponse {
        try await client.request(.updateUser(id: id), body: body)
    }
}
