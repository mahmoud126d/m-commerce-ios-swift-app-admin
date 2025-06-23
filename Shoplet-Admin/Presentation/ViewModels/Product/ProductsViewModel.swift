//
//  ProductViewModel.swift
//  Shoplet-Admin
//
//  Created by Macos on 03/06/2025.
//

import Foundation
class ProductsViewModel: ObservableObject {

    @Published var productList: [Product]?
    @Published var isLoading = true
    @Published var userError: NetworkError?
    var selectedProduct: Product? = nil
    @Published var toastMessage: String? = nil

    private let getProductsUseCase: GetProductsUseCaseProtocol
    private let deleteProductUseCase: DeleteProductsUseCaseProtocol
    private let createProductUseCase: CreateProductsUseCaseProtocol
    private let updateProductUseCase: UpdateProductUseCaseProtocol

    init(
        getProductsUseCase: GetProductsUseCaseProtocol,
        deleteProductUseCase: DeleteProductsUseCaseProtocol,
        createProductUseCase: CreateProductsUseCaseProtocol,
        updateProductUseCase: UpdateProductUseCaseProtocol
    ) {
        self.getProductsUseCase = getProductsUseCase
        self.deleteProductUseCase = deleteProductUseCase
        self.createProductUseCase = createProductUseCase
        self.updateProductUseCase = updateProductUseCase
    }

    func fetchProducts() {
        isLoading = true
        Task {
            do {
                let response = try await getProductsUseCase.execute()
                await MainActor.run {
                    self.productList = response.products
                    self.isLoading = false
                    self.userError = nil
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                    self.userError = error as? NetworkError
                }
            }
        }
    }

    func deleteProduct(productId: Int) {
        Task {
            do {
                _ = try await deleteProductUseCase.execute(productId: productId)
                await MainActor.run {
                    self.productList?.removeAll { $0.id == productId }
                    self.isLoading = false
                    self.userError = nil
                    self.toastMessage = "Product deleted"
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                    self.userError = error as? NetworkError
                }
            }
        }
    }

    func createProduct(product: ProductRequest) {
        Task {
            do {
                let created = try await createProductUseCase.execute(product: product)
                await MainActor.run {
                    self.productList?.append(created.product)
                    self.isLoading = false
                    self.userError = nil
                    self.toastMessage = "Product created"
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                    self.userError = error as? NetworkError
                }
            }
        }
    }

    func updateProduct(product: ProductRequest) {
        Task {
            do {
                let updated = try await updateProductUseCase.execute(product: product)
                await MainActor.run {
                    if let index = self.productList?.firstIndex(where: { $0.id == updated.product.id }) {
                        self.productList?[index] = updated.product
                    }
                    self.isLoading = false
                    self.userError = nil
                    self.toastMessage = "Product updated"
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                    self.userError = error as? NetworkError
                }
            }
        }
    }
}
