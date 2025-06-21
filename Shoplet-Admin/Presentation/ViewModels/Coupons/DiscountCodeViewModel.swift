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
            print("Failed to fetch discount codes: \(error.localizedDescription)")
        }
    }
    
    func createDiscountCode(ruleId: Int, discountCode: DiscountCodesRequest) async {
        do {
            let response = try await createDiscountCodesUseCase.execute(priceRuleId: ruleId, discountCode: discountCode)
            userError = nil
            discountCodes?.append(response.discountCode)
        } catch {
            userError = error as? NetworkError
            print("Failed to create discount code: \(error.localizedDescription)")
        }
    }
    
    func deleteDiscountCode(ruleId: Int, codeId: Int) async {
        do {
            _ = try await deleteDiscountCodesUseCase.execute(ruleId: ruleId, codeId: codeId)
            userError = nil
            print("Discount code deleted successfully!")
        } catch {
            userError = error as? NetworkError
            print("Failed to delete discount code: \(error.localizedDescription)")
        }
    }
    
    func updateDiscountCode(ruleId: Int, discountCode: DiscountCodesRequest) async {
        do {
            let response = try await updateDiscountCodesUseCase.execute(priceRuleId: ruleId, discountCode: discountCode)
            isLoading = false
            userError = nil
            if let index = discountCodes?.firstIndex(where: { $0.id == discountCode.discountCode.id }) {
                discountCodes?.remove(at: index)
            }
            discountCodes?.append(response.discountCode)
        } catch {
            userError = error as? NetworkError
            print("Failed to update discount code: \(error.localizedDescription)")
        }
    }
}
