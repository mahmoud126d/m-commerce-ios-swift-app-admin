//
//  DeletePriceRulesUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation

// MARK: - Get PriceRules UseCase
protocol DeletePriceRulesUseCaseProtocol {
    func execute(id: Int) async throws -> Empty
}

class DeletePriceRulesUseCase: DeletePriceRulesUseCaseProtocol {
    
    private let repository: CouponsRepositoryProtocol
    
    init(repository: CouponsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(id: Int) async throws -> Empty {
        try await repository.deletePriceRule(id: id)
    }
}
