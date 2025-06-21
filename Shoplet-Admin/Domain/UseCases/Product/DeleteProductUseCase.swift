//
//  DeleteProductUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 04/06/2025.
//

import Foundation

protocol DeleteProductsUseCaseProtocol {
    func execute(productId: Int) async throws -> Empty
}

class DeleteProductsUseCase: DeleteProductsUseCaseProtocol {
    
    private let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(productId: Int) async throws -> Empty {
        try await repository.deleteProduct(productId: productId)
    }
}
