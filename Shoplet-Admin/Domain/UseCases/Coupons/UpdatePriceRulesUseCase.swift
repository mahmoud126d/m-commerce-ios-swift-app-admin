//
//  UpdatePriceRulesUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation

// MARK: - Get PriceRules UseCase
protocol UpdatePriceRulesUseCaseProtocol {
    func execute(priceRule:PriceRuleRequest,completion: @escaping (Result<PriceRuleRequest, NetworkError>) -> Void)
}

class UpdatePriceRulesUseCase: UpdatePriceRulesUseCaseProtocol {
    
    private let repository: CouponsRepositoryProtocol
    
    init(repository: CouponsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(priceRule:PriceRuleRequest, completion: @escaping (Result<PriceRuleRequest, NetworkError>) -> Void) {
        repository.updatePriceRule(priceRule: priceRule) { result in
            completion(result)
        }
    }
}
