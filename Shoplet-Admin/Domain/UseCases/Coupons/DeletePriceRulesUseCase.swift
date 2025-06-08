//
//  DeletePriceRulesUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation

// MARK: - Get PriceRules UseCase
protocol DeletePriceRulesUseCaseProtocol {
    func execute(id:Int,completion: @escaping (Result<Empty, NetworkError>) -> Void)
}

class DeletePriceRulesUseCase: DeletePriceRulesUseCaseProtocol {
    
    private let repository: CouponsRepositoryProtocol
    
    init(repository: CouponsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(id:Int,completion: @escaping (Result<Empty, NetworkError>) -> Void) {
        repository.deletePriceRule(id: id) { result in
            completion(result)
        }
    }
}
