//
//  CreatePriceRulesUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation

// MARK: - Get PriceRules UseCase
protocol CreatePriceRulesUseCaseProtocol {
    func execute(priceRule:PriceRuleRequest,completion: @escaping (Result<PriceRuleRequest, NetworkError>) -> Void)
}

class CreatePriceRulesUseCase: CreatePriceRulesUseCaseProtocol {
    
    private let repository: CouponsRepositoryProtocol
    
    init(repository: CouponsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(priceRule:PriceRuleRequest,completion: @escaping (Result<PriceRuleRequest, NetworkError>) -> Void) {
        repository.createPriceRule(priceRule:priceRule ){ result in
            completion(result)
        }
    }
}
