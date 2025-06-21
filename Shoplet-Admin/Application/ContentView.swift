//
//  ContentView.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//
import SwiftUI

struct ContentView: View {
    
    @State var selectedTab: Tab = .products
    private let container = DIContainer.shared
    
    var body: some View {
        ZStack {
            VStack {
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
