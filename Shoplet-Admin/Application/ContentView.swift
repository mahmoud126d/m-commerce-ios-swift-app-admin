//
//  ContentView.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//
import SwiftUI

struct ContentView: View {
    
    @State var selectedTab: Tab = .products

    var body: some View {
        
        ZStack{
                    VStack {
                        switch selectedTab{
                        case .products:
                            ProductsView(viewModel: ProductsViewModel(getProductsUseCase: GetProductsUseCase(repository: ProductRepository()), deleteProductUseCase: DeleteProductsUseCase(repository: ProductRepository()), createProductUseCase: CreateProductsUseCase(repository: ProductRepository()), updateProductUseCase: UpdateProductUseCase(repository: ProductRepository())))
                        case .collections:
                            //CollectionsView()
                            Text("collections")
                            let repository = CollectionsRepository()

                            let viewModel = CollectionsViewModel(
                                getCollectionsUseCase: GetCollectionsUseCase(repository: repository),
                                createCollectionUseCase: CreateCollectionUseCase(repository: repository),
                                updateCollectionUseCase: UpdateCollectionUseCase(repository: repository),
                                deleteCollectionUseCase: DeleteCollectionUseCase(repository: repository)
                            )

                            CollectionsView(viewModel: viewModel)
                        case .priceRules:
                            PriceRulesView(viewModel : PriceRulesViewModel(
                                getPriceRulesUseCase: GetPriceRulesUseCase(repository: CouponsRepository()),
                                createPriceRulesUseCase: CreatePriceRulesUseCase(repository: CouponsRepository()),
                                deletePriceRulesUseCase: DeletePriceRulesUseCase(repository: CouponsRepository()),
                                updatePriceRulesUseCase: UpdatePriceRulesUseCase(repository: CouponsRepository()
                            ))
                                           )
                        }
                        Spacer()
                        CustomTabBarView(selectedTab: $selectedTab)
                        
                    }.ignoresSafeArea(edges: .bottom)
                
            
        }
            
    }
}

#Preview {
    ContentView()
}
