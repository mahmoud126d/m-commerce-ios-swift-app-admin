//
//  UpdatePriceRulesUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation

// MARK: - Get PriceRules UseCase
protocol UpdatePriceRulesUseCaseProtocol {
    func execute(priceRule: PriceRuleRequest) async throws -> PriceRuleRequest
}

class UpdatePriceRulesUseCase: UpdatePriceRulesUseCaseProtocol {
    
    private let repository: CouponsRepositoryProtocol
    
    init(repository: CouponsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(priceRule: PriceRuleRequest) async throws -> PriceRuleRequest {
        try await repository.updatePriceRule(priceRule: priceRule)
    }
}
