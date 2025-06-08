//
//  PriceRulesViewModel.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation

class PriceRulesViewModel: ObservableObject{
    
    @Published var priceRuleList:[PriceRule]?
    @Published var isLoading = true
    @Published var userError: NetworkError? = nil
    
    private let getPriceRulesUseCase : GetPriceRulesUseCaseProtocol
    private let createPriceRulesUseCase:CreatePriceRulesUseCaseProtocol
    private let deletePriceRulesUseCase:DeletePriceRulesUseCaseProtocol
    private let updatePriceRulesUseCase:UpdatePriceRulesUseCaseProtocol
    
    init(getPriceRulesUseCase: GetPriceRulesUseCaseProtocol, createPriceRulesUseCase: CreatePriceRulesUseCaseProtocol, deletePriceRulesUseCase: DeletePriceRulesUseCaseProtocol, updatePriceRulesUseCase: UpdatePriceRulesUseCaseProtocol) {
        self.getPriceRulesUseCase = getPriceRulesUseCase
        self.createPriceRulesUseCase = createPriceRulesUseCase
        self.deletePriceRulesUseCase = deletePriceRulesUseCase
        self.updatePriceRulesUseCase = updatePriceRulesUseCase
    }
    
    func getPriceRules(){
        getPriceRulesUseCase.execute{[weak self] result in
            switch result{
            case .success(let response):
                self?.isLoading = false
                self?.userError = nil
                self?.priceRuleList = response.priceRules
            case .failure(let error):
                self?.userError = error
            }
        }
    }
    func createPriceRule(priceRule:PriceRuleRequest){
        createPriceRulesUseCase.execute(priceRule: priceRule){ [weak self] result in
                switch result{
                case .success(_):
                    self?.isLoading = false
                    self?.userError = nil
                    self?.priceRuleList?.append(priceRule.priceRule)
                case .failure(let error):
                    self?.userError = error
                }
        }
    }
}
