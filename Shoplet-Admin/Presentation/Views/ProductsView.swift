//
//  ProductsView.swift
//  Shoplet-Admin
//
//  Created by Macos on 03/06/2025.
//

import SwiftUI

struct ProductsView: View {
    @StateObject private var viewModel: ProductViewModel
    @State var selectedTab: Tab = .products
    @State var openAddProductView: Bool = false

    init(viewModel: ProductViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack{
            HStack {
                Text("\(selectedTab.title)")
                    .font(.title)
                    .bold()
                Spacer()
                Button("+") {
                    print("add product button pressed")
                    openAddProductView.toggle()
                }
                .foregroundColor(.blue)
                .sheet(isPresented: $openAddProductView){
                    AddProductView(productViewModel: viewModel)
                }
            }
            .padding()
            
            List(viewModel.productList ?? [], id: \.id)  {product in
                ProductCustomCell(
                    productTitle: product.title ?? "",
                    productPrice: product.variants?.first?.price ?? "",
                    productCategory: product.productType ?? "", productImageURL:product.image?.src ?? "",
                    deleteAction: {
                        viewModel.deleteProduct(productId: product.id ?? 0)
                    },
                    editAction: {
                        
                    }
                )
            }            
            Spacer()
            CustomTabBarView(selectedTab: $selectedTab)
        }.onAppear{
            viewModel.fetchProducts()
        }
    }

}

#Preview {
    ProductsView(
        viewModel: ProductViewModel(getProductsUseCase: GetProductsUseCase(repository: ProductRepository()), deleteProductUseCase: DeleteProductsUseCase(repository: ProductRepository()), createProductUseCase: CreateProductsUseCase(repository: ProductRepository())))
}
