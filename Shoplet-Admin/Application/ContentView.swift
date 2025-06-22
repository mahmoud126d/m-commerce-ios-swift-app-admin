import SwiftUI

struct ContentView: View {
    
    @State var selectedTab: Tab = .products
    private let container = DIContainer.shared
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Image("logo1")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60)
                        .padding(.leading, 16)
                    Spacer()
                }
                .padding(.top, 16)
                
                switch selectedTab {
                case .products:
                    ProductsView(viewModel: container.resolve(ProductsViewModel.self))
                    
                case .collections:
                    CollectionsView(viewModel: container.resolve(CollectionsViewModel.self))
                    
                case .priceRules:
                    PriceRulesView(viewModel: container.resolve(PriceRulesViewModel.self))
                }

                Spacer()
                
                CustomTabBarView(selectedTab: $selectedTab)
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    ContentView()
}
