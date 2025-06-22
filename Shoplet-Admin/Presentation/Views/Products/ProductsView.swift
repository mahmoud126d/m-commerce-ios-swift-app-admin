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
    @State private var selectedProduct: Product? = nil

    init(viewModel: ProductsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 8) {
//                Text("Products")
//                    .font(.largeTitle)
//                    .bold()
//                    .foregroundColor(.primaryColor)
//                    .padding(.horizontal)

                Button(action: {
                    openAddProductView.toggle()
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add New Product")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryColor)
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                .sheet(isPresented: $openAddProductView, onDismiss: {
                    selectedProduct = nil
                }) {
                    AddProductView(product: selectedProduct, productViewModel: viewModel)
                }
            }
            .padding(.top)

            // Main content
            if viewModel.isLoading {
                Spacer()
                ProgressView("Loading products...")
                Spacer()
            } else if let products = viewModel.productList, !products.isEmpty {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(products, id: \.id) { product in
                            VStack(alignment: .leading, spacing: 8) {
                                ZStack(alignment: .topTrailing) {
                                    AsyncImage(url: URL(string: product.image?.src ?? "")) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(height: 180)
                                            .clipped()
                                            .cornerRadius(10)
                                    } placeholder: {
                                        Color.gray.opacity(0.1)
                                            .frame(height: 180)
                                            .cornerRadius(10)
                                    }

                                    HStack(spacing: 16) {
                                        Button(action: {
                                            selectedProduct = product
                                            openAddProductView = true
                                        }) {
                                            Image(systemName: "pencil")
                                                .font(.system(size: 18, weight: .semibold))
                                                .foregroundColor(.blue)
                                        }

                                        Button(action: {
                                            viewModel.deleteProduct(productId: product.id ?? 0)
                                        }) {
                                            Image(systemName: "trash")
                                                .font(.system(size: 18, weight: .semibold))
                                                .foregroundColor(.red)
                                        }
                                    }
                                    .padding(12)
                                }

                                Text(product.title ?? "")
                                    .font(.headline)
                                    .foregroundColor(.primaryColor)

                                Text("Category: \(product.productType ?? "")")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)

                                if let price = product.variants?.first?.price {
                                    Text("Price: \(price) USD")
                                        .foregroundColor(.red)
                                        .fontWeight(.bold)
                                        .padding(.bottom, 8)
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 4)
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top, 8)
                }
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
        viewModel: ProductsViewModel(
            getProductsUseCase: GetProductsUseCase(repository: ProductRepository()),
            deleteProductUseCase: DeleteProductsUseCase(repository: ProductRepository()),
            createProductUseCase: CreateProductsUseCase(repository: ProductRepository()),
            updateProductUseCase: UpdateProductUseCase(repository: ProductRepository())
        )
    )
}


#Preview {
    ProductsView(
        viewModel: ProductsViewModel(
            getProductsUseCase: GetProductsUseCase(repository: ProductRepository()),
            deleteProductUseCase: DeleteProductsUseCase(repository: ProductRepository()),
            createProductUseCase: CreateProductsUseCase(repository: ProductRepository()),
            updateProductUseCase: UpdateProductUseCase(repository: ProductRepository())
        )
    )
}
