import SwiftUI

struct ContentView: View {
    
    @State var selectedTab: Tab = .products
    private let container = DIContainer.shared
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {                
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
