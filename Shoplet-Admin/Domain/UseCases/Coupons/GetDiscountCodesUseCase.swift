//
//  GetDiscountCodesUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation

// MARK: - Get DiscountCodes UseCase
protocol GetDiscountCodesUseCaseProtocol {
    func execute(priceRuleId: Int, completion: @escaping (Result<DiscountCodesResponse, NetworkError>) -> Void)
}

class GetDiscountCodesUseCase: GetDiscountCodesUseCaseProtocol {
    
    private let repository: CouponsRepositoryProtocol
    
    init(repository: CouponsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(priceRuleId: Int, completion: @escaping (Result<DiscountCodesResponse, NetworkError>) -> Void) {
        repository.getDiscountCodes(priceRuleId: priceRuleId) { result in
            completion(result)
        }
    }
}
