//
//  ProductsView.swift
//  Shoplet-Admin
//
//  Created by Macos on 03/06/2025.
//

import SwiftUI

struct ProductsView: View {
    @StateObject private var viewModel: ProductsViewModel
    @State var selectedTab: Tab = .products
    @State var openAddProductView: Bool = false

    @State private var showAlert = false
    
    @State private var selectedProduct:Product? = nil
    init(viewModel: ProductsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Top Bar
            HStack {
                Text(selectedTab.title)
                    .font(.largeTitle)
                    .bold()

                Spacer()

                Button(action: {
                    openAddProductView.toggle()
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
                .sheet(isPresented: $openAddProductView,onDismiss: {
                    selectedProduct = nil
                }) {
                    AddProductView(product: selectedProduct ,productViewModel: viewModel)
                }
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(15)
            .padding(.horizontal)
            .padding(.top)

            // Main Content
            if viewModel.isLoading {
                Spacer()
                ProgressView("Loading products...")
                Spacer()
            } else if let products = viewModel.productList, !products.isEmpty {
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
                            // edit logic
                            selectedProduct = product
                            openAddProductView = true
                        }
                    )
                    .listRowSeparator(.hidden)
                    .padding(.vertical, 8)
                    .listRowInsets(EdgeInsets())
                }
                .listStyle(PlainListStyle())
            } else {
                Spacer()
                Text("No products found.")
                    .foregroundColor(.gray)
                Spacer()
            }

        }
        .background(Color.white.ignoresSafeArea())
        .onAppear {
            viewModel.fetchProducts()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.userError?.localizedDescription ?? "Unknown error"),
                dismissButton: .default(Text("OK"))
            )
        }
        .onChange(of: viewModel.userError) { newValue in
            showAlert = newValue != nil
        }
    }

}

#Preview {
    ProductsView(
        viewModel: ProductsViewModel(getProductsUseCase: GetProductsUseCase(repository: ProductRepository()), deleteProductUseCase: DeleteProductsUseCase(repository: ProductRepository()), createProductUseCase: CreateProductsUseCase(repository: ProductRepository()), updateProductUseCase: UpdateProductUseCase(repository: ProductRepository())))
}
