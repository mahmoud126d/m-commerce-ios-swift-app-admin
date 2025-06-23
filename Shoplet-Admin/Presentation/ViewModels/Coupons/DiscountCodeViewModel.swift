//
//  DiscountCodeViewModel.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation

@MainActor
class DiscountCodeViewModel: ObservableObject {
    @Published var discountCodes: [DiscountCode]?
    @Published var userError: NetworkError?
    @Published var isLoading = true
    @Published var toastMessage: String? = nil
    
    private let getDiscountCodesUseCase: GetDiscountCodesUseCaseProtocol
    private let createDiscountCodesUseCase: CreateDiscountCodeUseCaseProtocol
    private let deleteDiscountCodesUseCase: DeleteDiscountCodeUseCaseProtocol
    private let updateDiscountCodesUseCase: UpdateDiscountCodeUseCaseProtocol
    
    init(
        getDiscountCodesUseCase: GetDiscountCodesUseCaseProtocol,
        createDiscountCodesUseCase: CreateDiscountCodeUseCaseProtocol,
        deleteDiscountCodesUseCase: DeleteDiscountCodeUseCaseProtocol,
        updateDiscountCodesUseCase: UpdateDiscountCodeUseCaseProtocol
    ) {
        self.getDiscountCodesUseCase = getDiscountCodesUseCase
        self.createDiscountCodesUseCase = createDiscountCodesUseCase
        self.deleteDiscountCodesUseCase = deleteDiscountCodesUseCase
        self.updateDiscountCodesUseCase = updateDiscountCodesUseCase
    }
    
    func getDiscountCodes(ruleId: Int) async {
        do {
            let response = try await getDiscountCodesUseCase.execute(priceRuleId: ruleId)
            isLoading = false
            userError = nil
            discountCodes = response.discountCodes
        } catch {
            isLoading = false
            userError = error as? NetworkError
        }
    }
    
    func createDiscountCode(ruleId: Int, discountCode: DiscountCodesRequest) async {
        do {
            let response = try await createDiscountCodesUseCase.execute(priceRuleId: ruleId, discountCode: discountCode)
            userError = nil
            await self.getDiscountCodes(ruleId: ruleId)
            self.toastMessage = "DiscountCode created"
        } catch {
            userError = error as? NetworkError
        }
    }
    
    func deleteDiscountCode(ruleId: Int, codeId: Int) async {
        do {
            _ = try await deleteDiscountCodesUseCase.execute(ruleId: ruleId, codeId: codeId)
            userError = nil
            await self.getDiscountCodes(ruleId: ruleId)
            self.toastMessage = "DiscountCode deleted"
        } catch {
            userError = error as? NetworkError
        }
    }
    
    func updateDiscountCode(ruleId: Int, discountCode: DiscountCodesRequest) async {
        do {
            let response = try await updateDiscountCodesUseCase.execute(priceRuleId: ruleId, discountCode: discountCode)
            isLoading = false
            userError = nil
            await self.getDiscountCodes(ruleId: ruleId)
            self.toastMessage = "DiscountCode updated"
        } catch {
            userError = error as? NetworkError
        }
    }
}
