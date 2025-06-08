//
//  GetPriceRulesUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation

// MARK: - Get PriceRules UseCase
protocol GetPriceRulesUseCaseProtocol {
    func execute(completion: @escaping (Result<PriceRulesResponse, NetworkError>) -> Void)
}

class GetPriceRulesUseCase: GetPriceRulesUseCaseProtocol {
    
    private let repository: CouponsRepositoryProtocol
    
    init(repository: CouponsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(completion: @escaping (Result<PriceRulesResponse, NetworkError>) -> Void) {
        repository.getPriceRules { result in
            completion(result)
        }
    }
}
