//
//  PriceRulesViewModel.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation

class PriceRulesViewModel: ObservableObject {

    @Published var priceRuleList: [PriceRule]?
    @Published var isLoading = true
    @Published var userError: NetworkError?
    @Published var toastMessage: String? = nil
    
    private let getPriceRulesUseCase: GetPriceRulesUseCaseProtocol
    private let createPriceRulesUseCase: CreatePriceRulesUseCaseProtocol
    private let deletePriceRulesUseCase: DeletePriceRulesUseCaseProtocol
    private let updatePriceRulesUseCase: UpdatePriceRulesUseCaseProtocol

    init(
        getPriceRulesUseCase: GetPriceRulesUseCaseProtocol,
        createPriceRulesUseCase: CreatePriceRulesUseCaseProtocol,
        deletePriceRulesUseCase: DeletePriceRulesUseCaseProtocol,
        updatePriceRulesUseCase: UpdatePriceRulesUseCaseProtocol
    ) {
        self.getPriceRulesUseCase = getPriceRulesUseCase
        self.createPriceRulesUseCase = createPriceRulesUseCase
        self.deletePriceRulesUseCase = deletePriceRulesUseCase
        self.updatePriceRulesUseCase = updatePriceRulesUseCase
    }

    func getPriceRules() {
        isLoading = true
        Task {
            do {
                let response = try await getPriceRulesUseCase.execute()
                await MainActor.run {
                    self.priceRuleList = response.priceRules
                    self.isLoading = false
                    self.userError = nil
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                    self.userError = error as? NetworkError
                }
            }
        }
    }

    func createPriceRule(priceRule: PriceRuleRequest) {
        isLoading = true
        Task {
            do {
                let created = try await createPriceRulesUseCase.execute(priceRule: priceRule)
                await MainActor.run {
                    self.priceRuleList?.append(created.priceRule)
                    self.isLoading = false
                    self.userError = nil
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                    self.userError = error as? NetworkError
                }
            }
        }
    }

    func deletePriceRule(id: Int) {
        isLoading = true
        Task {
            do {
                _ = try await deletePriceRulesUseCase.execute(id: id)
                await MainActor.run {
                    self.priceRuleList?.removeAll { $0.id == id }
                    self.isLoading = false
                    self.userError = nil
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                    self.userError = error as? NetworkError
                }
            }
        }
    }

    func updatePriceRule(priceRule: PriceRuleRequest) {
        isLoading = true
        Task {
            do {
                let updated = try await updatePriceRulesUseCase.execute(priceRule: priceRule)
                await MainActor.run {
                    if let index = self.priceRuleList?.firstIndex(where: { $0.id == updated.priceRule.id }) {
                        self.priceRuleList?[index] = updated.priceRule
                    } else {
                        self.priceRuleList?.append(updated.priceRule)
                    }
                    self.isLoading = false
                    self.userError = nil
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                    self.userError = error as? NetworkError
                }
            }
        }
    }
}
