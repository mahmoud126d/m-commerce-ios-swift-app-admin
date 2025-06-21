//
//  CreateProductUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 04/06/2025.
//

import Foundation

protocol CreateProductsUseCaseProtocol {
    func execute(product: ProductRequest) async throws -> ProductRequest
}

class CreateProductsUseCase: CreateProductsUseCaseProtocol {
    
    private let repository: ProductRepositoryProtocol

    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }

    func execute(product: ProductRequest) async throws -> ProductRequest {
        try await repository.createProduct(product: product)
    }
}
