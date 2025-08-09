import Foundation
import SwiftUI
import CepteBulNetworking

@MainActor
final class BusinessListViewModel: ObservableObject {
    @Published var businesses: [Business] = []
    @Published var error: String?
    
    private let service: BusinessService
    
    init(service: BusinessService) {
        self.service = service
    }
    
    func load() async {
        do {
            businesses = try await service.listBusinesses()
        } catch {
            if let apiError = error as? APIError {
                self.error = apiError.message
            } else {
                self.error = error.localizedDescription
            }
        }
    }
}
