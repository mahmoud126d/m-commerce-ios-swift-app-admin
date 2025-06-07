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
        VStack(spacing: 0) {
            // Top Bar with Title and Add Button
            HStack {
                Text(selectedTab.title)
                    .font(.largeTitle)
                    .bold()

                Spacer()

                Button(action: {
                    print("Add product button pressed")
                    openAddProductView.toggle()
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
                .sheet(isPresented: $openAddProductView) {
                    AddProductView(productViewModel: viewModel)
                }
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(15)
            .padding(.horizontal)
            .padding(.top)

            // Product List
            if let products = viewModel.productList, !products.isEmpty {
                List(products, id: \.id) { product in
                    ProductCustomCell(
                        productTitle: product.title ?? "",
                        productPrice: product.variants?.first?.price ?? "",
                        productCategory: product.productType ?? "",
                        productImageURL: product.image?.src ?? "",
                        deleteAction: {
                            viewModel.deleteProduct(productId: product.id ?? 0)
                        },
                        editAction: {

                            
                        }
                    )
                    .listRowSeparator(.hidden)
                    .padding(.vertical, 8)
                    .listRowInsets(EdgeInsets())
                }
                .listStyle(PlainListStyle())
            } else {
                Spacer()
                VStack(spacing: 10) {
                    ProgressView("Loading products...")
                }
                Spacer()
            }

            CustomTabBarView(selectedTab: $selectedTab)
        }
        .background(Color.white.ignoresSafeArea())
        .onAppear {
            viewModel.fetchProducts()
        }

    }

}

#Preview {
    ProductsView(
        viewModel: ProductViewModel(getProductsUseCase: GetProductsUseCase(repository: ProductRepository()), deleteProductUseCase: DeleteProductsUseCase(repository: ProductRepository()), createProductUseCase: CreateProductsUseCase(repository: ProductRepository())))
}
