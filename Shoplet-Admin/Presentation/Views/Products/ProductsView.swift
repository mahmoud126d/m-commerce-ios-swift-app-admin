//
//  ProductsView.swift
//  Shoplet-Admin
//
//  Created by Macos on 03/06/2025.
//
import SwiftUI

struct ProductsView: View {
    @StateObject private var viewModel: ProductsViewModel
    @State private var openAddProductView: Bool = false
    @State private var showAlert = false
    @State private var showToast = false

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    init(viewModel: ProductsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 8) {
                Button(action: {
                    viewModel.selectedProduct = nil
                    openAddProductView = true
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
                    .padding()
                }
                .sheet(isPresented: $openAddProductView, onDismiss: {
                    viewModel.selectedProduct = nil
                }) {
                    AddProductView(product: viewModel.selectedProduct, productViewModel: viewModel)
                }
            }
            .padding(.top)

            if viewModel.isLoading {
                Spacer()
                ProgressView("Loading products...")
                Spacer()
            } else if let products = viewModel.productList, !products.isEmpty {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(products, id: \.id) { product in
                            VStack(alignment: .leading, spacing: 8) {
                                AsyncImage(url: URL(string: product.image?.src ?? "")) { phase in
                                    switch phase {
                                    case .empty:
                                        Color.gray.opacity(0.1)
                                    case .success(let image):
                                        image.resizable().scaledToFit()
                                    case .failure:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.gray)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .frame(height: 150)
                                .frame(maxWidth: .infinity)
                                .background(Color.gray.opacity(0.05))
                                .cornerRadius(10)
                                .overlay(alignment: .topTrailing) {
                                    HStack(spacing: 8) {
                                        Button {
                                            viewModel.selectedProduct = product
                                            openAddProductView = true
                                        } label: {
                                            Image(systemName: "pencil")
                                                .font(.system(size: 16, weight: .semibold))
                                                .foregroundColor(.white)
                                                .frame(width: 32, height: 32)
                                                .background(Color.blue.opacity(0.8))
                                                .cornerRadius(6)
                                        }

                                        Button {
                                            viewModel.deleteProduct(productId: product.id ?? 0)
                                        } label: {
                                            Image(systemName: "trash")
                                                .font(.system(size: 16, weight: .semibold))
                                                .foregroundColor(.white)
                                                .frame(width: 32, height: 32)
                                                .background(Color.red.opacity(0.8))
                                                .cornerRadius(6)
                                        }
                                    }
                                    .padding(8)
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(product.title ?? "No Title")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                        .lineLimit(2)

                                    Text("Category: \(product.productType ?? "Unknown")")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)

                                    if let price = product.variants?.first?.price {
                                        Text("Price: \(price) USD")
                                            .font(.subheadline)
                                            .foregroundColor(.red)
                                            .fontWeight(.semibold)
                                    }
                                }
                            }
                            .padding(12)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                        }
                    }
                    .padding(.horizontal, 16)
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
        .onChange(of: viewModel.toastMessage) { message in
            if message != nil {
                withAnimation {
                    showToast = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    viewModel.toastMessage = nil
                }
            }
        }
        .onChange(of: viewModel.userError) { error in
            showAlert = error != nil
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.userError?.localizedDescription ?? "Unknown error"),
                dismissButton: .default(Text("OK")) {
                    viewModel.userError = nil
                }
            )
        }
        .toast(isPresented: $showToast, message: viewModel.toastMessage ?? "")
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

struct ToastMessageView: View {
    var message: String

    var body: some View {
        Text(message)
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(0.85))
            .cornerRadius(10)
    }
}

