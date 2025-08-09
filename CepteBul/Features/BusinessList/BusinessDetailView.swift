import SwiftUI

struct BusinessDetailView: View {
    let business: Business

    var body: some View {
        Text(business.name)
            .font(.title)
            .padding()
    }
}

#Preview {
    BusinessDetailView(business: Business(id: "1", name: "Örnek İşletme", location: "İstanbul"))
}
