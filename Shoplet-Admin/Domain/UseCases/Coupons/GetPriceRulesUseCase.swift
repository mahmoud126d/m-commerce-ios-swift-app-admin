//
//  GetPriceRulesUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation

// MARK: - Get PriceRules UseCase
protocol GetPriceRulesUseCaseProtocol {
    func execute() async throws -> PriceRulesResponse
}

class GetPriceRulesUseCase: GetPriceRulesUseCaseProtocol {
    
    private let repository: CouponsRepositoryProtocol
    
    init(repository: CouponsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> PriceRulesResponse {
        try await repository.getPriceRules()
    }
}
