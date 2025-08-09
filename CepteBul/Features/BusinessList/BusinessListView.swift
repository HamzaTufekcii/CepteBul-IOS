import SwiftUI
import CepteBulNetworking

struct BusinessListView: View {
    @StateObject var viewModel: BusinessListViewModel
    
    var body: some View {
        List(viewModel.businesses, id: \.id) { business in
            VStack(alignment: .leading) {
                Text(business.name)
                Text(business.location)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .task { await viewModel.load() }
    }
}

#Preview {
    BusinessListView(viewModel: BusinessListViewModel(service: BusinessService(client: APIClient())))
}
