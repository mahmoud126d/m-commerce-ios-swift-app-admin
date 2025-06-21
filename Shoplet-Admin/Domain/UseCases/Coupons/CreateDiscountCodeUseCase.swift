//
//  CreateDiscountCodeUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation

// MARK: - Create DiscountCode UseCase
protocol CreateDiscountCodeUseCaseProtocol {
    func execute(priceRuleId: Int, discountCode: DiscountCodesRequest) async throws -> DiscountCodesRequest
}

class CreateDiscountCodeUseCase: CreateDiscountCodeUseCaseProtocol {
    
    private let repository: CouponsRepositoryProtocol
    
    init(repository: CouponsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(priceRuleId: Int, discountCode: DiscountCodesRequest) async throws -> DiscountCodesRequest {
        try await repository.createDiscountCode(priceRuleId: priceRuleId, discountCode: discountCode)
    }
}
