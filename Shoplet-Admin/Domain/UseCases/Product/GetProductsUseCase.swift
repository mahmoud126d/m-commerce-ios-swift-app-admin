//
//  GetProductsUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 03/06/2025.
//

import Foundation

// MARK: - Get Products UseCase
protocol GetProductsUseCaseProtocol {
    func execute(completion: @escaping (Result<ProductsResponse, NetworkError>) -> Void)
}

class GetProductsUseCase: GetProductsUseCaseProtocol {
    
    private let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(completion: @escaping (Result<ProductsResponse, NetworkError>) -> Void) {
        repository.getProducts { result in
            completion(result)
        }
    }
}

