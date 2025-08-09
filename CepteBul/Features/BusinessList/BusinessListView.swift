import SwiftUI

struct BusinessListView: View {
    @StateObject var viewModel: BusinessListViewModel

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.businesses, id: \.id) { business in
                    NavigationLink(destination: BusinessDetailView(business: business)) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(business.name)
                                .font(.headline)
                            Text(business.location)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.2))
                        )
                    }
                }
            }
            .padding()
        }
        .task { await viewModel.load() }
    }
}

#Preview {
    BusinessListView(viewModel: BusinessListViewModel(service: BusinessService(client: APIClient())))
}
