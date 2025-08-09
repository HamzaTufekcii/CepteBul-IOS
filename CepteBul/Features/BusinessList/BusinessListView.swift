import SwiftUI
import CepteBulNetworking

struct BusinessListView: View {
    @StateObject var viewModel: BusinessListViewModel
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.businesses, id: \.id) { business in
                    Button(action: {
                        print("Tapped \(business.name)")
                    }) {
                        Text(business.name)
                            .frame(maxWidth: .infinity, minHeight: 80)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.primary)
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
