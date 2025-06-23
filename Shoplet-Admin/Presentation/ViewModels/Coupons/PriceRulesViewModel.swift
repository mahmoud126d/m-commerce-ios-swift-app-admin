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
    var selectedPriceRule: PriceRule? = nil
    
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
        Task {
            do {
                let created = try await createPriceRulesUseCase.execute(priceRule: priceRule)
                await MainActor.run {
                    self.getPriceRules()
                    self.isLoading = false
                    self.userError = nil
                    self.toastMessage = "PriceRule created"
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
        Task {
            do {
                _ = try await deletePriceRulesUseCase.execute(id: id)
                await MainActor.run {
                    self.getPriceRules()
                    self.isLoading = false
                    self.userError = nil
                    self.toastMessage = "PriceRule deleted"
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
        Task {
            do {
                let updated = try await updatePriceRulesUseCase.execute(priceRule: priceRule)
                await MainActor.run {
                    self.getPriceRules()
                    self.isLoading = false
                    self.userError = nil
                    self.toastMessage = "PriceRule updated"
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
