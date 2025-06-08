//
//  CreateProductUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 04/06/2025.
//

import Foundation

protocol CreateProductsUseCaseProtocol {
    func execute(product:ProductRequest,completion: @escaping (Result<ProductRequest, NetworkError>) -> Void)
}

class CreateProductsUseCase: CreateProductsUseCaseProtocol {
   
    private let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(product:ProductRequest,completion: @escaping (Result<ProductRequest, NetworkError>) -> Void) {
        repository.createProduct(product: product) { result in
            completion(result)
        }
    }
}
