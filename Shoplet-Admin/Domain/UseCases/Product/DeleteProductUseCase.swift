//
//  DeleteProductUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 04/06/2025.
//

import Foundation

protocol DeleteProductsUseCaseProtocol {
    func execute(productId:Int,completion: @escaping (Result<Empty, NetworkError>) -> Void)
}

class DeleteProductsUseCase: DeleteProductsUseCaseProtocol {
    
    private let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(productId:Int,completion: @escaping (Result<Empty, NetworkError>) -> Void) {
        repository.deleteProduct(productId: productId) { result in
            completion(result)
        }
    }
}
