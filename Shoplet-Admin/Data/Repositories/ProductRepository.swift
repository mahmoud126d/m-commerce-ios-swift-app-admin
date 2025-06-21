//
//  ProductRepository.swift
//  Shoplet-Admin
//
//  Created by Macos on 03/06/2025.
//

import Foundation

class ProductRepository: ProductRepositoryProtocol {
    
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }

    func getProducts() async throws -> ProductsResponse {
        try await networkManager.getProducts()
    }

    func deleteProduct(productId: Int) async throws -> Empty {
        try await networkManager.deleteProduct(id: productId)
    }

    func createProduct(product: ProductRequest) async throws -> ProductRequest {
        try await networkManager.createProduct(product: product)
    }

    func updateProduct(product: ProductRequest) async throws -> ProductRequest {
        try await networkManager.updateProduct(product: product)
    }
}
