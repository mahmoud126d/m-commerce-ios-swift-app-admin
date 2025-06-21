//
//  DeleteDiscountCodeUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation

// MARK: - Get DiscountCode UseCase
protocol DeleteDiscountCodeUseCaseProtocol {
    func execute(ruleId: Int, codeId: Int) async throws -> Empty
}

class DeleteDiscountCodeUseCase: DeleteDiscountCodeUseCaseProtocol {
    
    private let repository: CouponsRepositoryProtocol
    
    init(repository: CouponsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(ruleId: Int, codeId: Int) async throws -> Empty {
        try await repository.deleteDiscountCode(ruleId: ruleId, codeId: codeId)
    }
}
