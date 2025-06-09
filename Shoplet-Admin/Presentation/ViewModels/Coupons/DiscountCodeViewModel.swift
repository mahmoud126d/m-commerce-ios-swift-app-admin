//
//  DiscountCodeViewModel.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation

class DiscountCodeViewModel : ObservableObject{
    @Published var discountCodes:[DiscountCode]?
    @Published var userError: NetworkError? = nil
    @Published var isLoading = true
    
    private let getDiscountCodesUseCase : GetDiscountCodesUseCaseProtocol
    private let createDiscountCodesUseCase : CreateDiscountCodeUseCaseProtocol
    private let deleteDiscountCodesUseCase : DeleteDiscountCodeUseCaseProtocol
    private let updateDiscountCodesUseCase : UpdateDiscountCodeUseCaseProtocol

    init(getDiscountCodesUseCase: GetDiscountCodesUseCaseProtocol, createDiscountCodesUseCase: CreateDiscountCodeUseCaseProtocol, deleteDiscountCodesUseCase: DeleteDiscountCodeUseCaseProtocol, updateDiscountCodesUseCase: UpdateDiscountCodeUseCaseProtocol) {
        self.getDiscountCodesUseCase = getDiscountCodesUseCase
        self.createDiscountCodesUseCase = createDiscountCodesUseCase
        self.deleteDiscountCodesUseCase = deleteDiscountCodesUseCase
        self.updateDiscountCodesUseCase = updateDiscountCodesUseCase
    }
    
    func getDiscountCodes(ruleId: Int) {
        getDiscountCodesUseCase.execute(priceRuleId: ruleId) { [weak self] result in
            switch result {
            case .success(let codes):
                self?.isLoading = false
                self?.userError = nil
                self?.discountCodes = codes.discountCodes
            case .failure(let error):
                self?.isLoading = false
                self?.userError = error
            }
        }
    }
    
    func createDiscountCode(ruleId: Int, discountCode: DiscountCodesRequest) {
        createDiscountCodesUseCase.execute(priceRuleId: ruleId, discountCode: discountCode) {[weak self] result in
            switch result {
            case .success(let response):
                self?.userError = nil
                self?.discountCodes?.append(response.discountCode)
            case .failure(let error):
                self?.userError = error
            }
        }
    }
    
    
    func deleteDiscountCode(ruleId: Int, codeId: Int) {
        deleteDiscountCodesUseCase.execute(ruleId: ruleId, codeId: codeId){[weak self] result in
            switch result {
            case .success:
                self?.userError = nil
                print("Discount code deleted successfully!")
            case .failure(let error):
                print("Failed to delete discount code: \(error.localizedDescription)")
            }
            
        }
    }
    func updateDiscountCode(ruleId: Int, discountCode: DiscountCodesRequest){
        updateDiscountCodesUseCase.execute(priceRuleId: ruleId, discountCode: discountCode){[weak self] result in
                switch result{
                case .success(_):
                    self?.isLoading = false
                    self?.userError = nil
                    if let index = self?.discountCodes?.firstIndex(where: { $0.id == discountCode.discountCode.id }) {
                        self?.discountCodes?.remove(at: index)
                    }
                    self?.discountCodes?.append(discountCode.discountCode)
                case .failure(let error):
                    self?.userError = error
                }
        }
    }
}
