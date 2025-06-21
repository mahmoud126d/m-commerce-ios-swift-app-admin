//
//  UpdateProductUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 14/06/2025.
//

import Foundation

protocol UpdateProductUseCaseProtocol {
    func execute(product: ProductRequest) async throws -> ProductRequest
}

class UpdateProductUseCase: UpdateProductUseCaseProtocol {

    private let repository: ProductRepositoryProtocol

    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }

    func execute(product: ProductRequest) async throws -> ProductRequest {
        try await repository.updateProduct(product: product)
    }
}

