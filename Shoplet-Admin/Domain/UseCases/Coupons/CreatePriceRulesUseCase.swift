//
//  CreatePriceRulesUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation

// MARK: - Get PriceRules UseCase
protocol CreatePriceRulesUseCaseProtocol {
    func execute(priceRule: PriceRuleRequest) async throws -> PriceRuleRequest
}

class CreatePriceRulesUseCase: CreatePriceRulesUseCaseProtocol {
    
    private let repository: CouponsRepositoryProtocol
    
    init(repository: CouponsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(priceRule: PriceRuleRequest) async throws -> PriceRuleRequest {
        try await repository.createPriceRule(priceRule: priceRule)
    }
}
