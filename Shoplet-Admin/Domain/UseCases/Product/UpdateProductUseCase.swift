//
//  UpdateProductUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 14/06/2025.
//

import Foundation

protocol UpdateProductUseCaseProtocol {
    func execute(product:ProductRequest,completion: @escaping (Result<ProductRequest, NetworkError>) -> Void)
}

class UpdateProductUseCase: UpdateProductUseCaseProtocol {
   
    private let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(product:ProductRequest,completion: @escaping (Result<ProductRequest, NetworkError>) -> Void) {
        repository.updateProduct(product: product) { result in
            completion(result)
        }
    }
}
