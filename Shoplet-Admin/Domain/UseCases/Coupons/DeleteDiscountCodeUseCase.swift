//
//  DeleteDiscountCodeUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation

// MARK: - Get DiscountCode UseCase
protocol DeleteDiscountCodeUseCaseProtocol {
    func execute(ruleId: Int, codeId: Int, completion: @escaping (Result<Empty, NetworkError>) -> Void)
}

class DeleteDiscountCodeUseCase: DeleteDiscountCodeUseCaseProtocol {
    
    private let repository: CouponsRepositoryProtocol
    
    init(repository: CouponsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(ruleId: Int, codeId: Int, completion: @escaping (Result<Empty, NetworkError>) -> Void) {
        repository.deleteDiscountCode(ruleId: ruleId, codeId: codeId) { result in
            completion(result)
        }
    }
}
