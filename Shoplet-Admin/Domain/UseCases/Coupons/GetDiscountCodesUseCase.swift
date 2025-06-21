//
//  GetDiscountCodesUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation

// MARK: - Get DiscountCodes UseCase
protocol GetDiscountCodesUseCaseProtocol {
    func execute(priceRuleId: Int) async throws -> DiscountCodesResponse
}

class GetDiscountCodesUseCase: GetDiscountCodesUseCaseProtocol {
    
    private let repository: CouponsRepositoryProtocol
    
    init(repository: CouponsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(priceRuleId: Int) async throws -> DiscountCodesResponse {
        try await repository.getDiscountCodes(priceRuleId: priceRuleId)
    }
}
