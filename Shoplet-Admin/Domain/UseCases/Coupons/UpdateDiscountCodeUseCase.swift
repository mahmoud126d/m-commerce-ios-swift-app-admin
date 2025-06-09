//
//  UpdateDiscountCodeUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation

// MARK: - Update DiscountCode UseCase
protocol UpdateDiscountCodeUseCaseProtocol {
    func execute(priceRuleId: Int, discountCode: DiscountCodesRequest, completion: @escaping (Result<DiscountCodesRequest, NetworkError>) -> Void)
}
class UpdateDiscountCodeUseCase: UpdateDiscountCodeUseCaseProtocol {
    
    private let repository: CouponsRepositoryProtocol
    
    init(repository: CouponsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(priceRuleId: Int, discountCode: DiscountCodesRequest, completion: @escaping (Result<DiscountCodesRequest, NetworkError>) -> Void) {
        repository.updateDiscountCode(priceRuleId: priceRuleId, discountCode: discountCode){result in
           completion(result)
        }
    }
}
