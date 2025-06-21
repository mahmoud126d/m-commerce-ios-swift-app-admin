//
//  GetProductsUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 03/06/2025.
//

import Foundation

// MARK: - Get Products UseCase
protocol GetProductsUseCaseProtocol {
    func execute() async throws -> ProductsResponse
}

class GetProductsUseCase: GetProductsUseCaseProtocol {
    
    private let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> ProductsResponse {
        try await repository.getProducts()
    }
}
