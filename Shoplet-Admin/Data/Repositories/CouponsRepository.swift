//
//  CouponsRepository.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation


class CouponsRepository: CouponsRepositoryProtocol {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getPriceRules() async throws -> PriceRulesResponse {
        try await networkManager.getPriceRules()
    }
    
    func createPriceRule(priceRule: PriceRuleRequest) async throws -> PriceRuleRequest {
        try await networkManager.createPriceRule(rule: priceRule)
    }
    
    func deletePriceRule(id: Int) async throws -> Empty {
        try await networkManager.deletePriceRule(id: id)
    }
    
    func updatePriceRule(priceRule: PriceRuleRequest) async throws -> PriceRuleRequest {
        try await networkManager.updatePriceRule(priceRuleRequest: priceRule)
    }
    
    func getDiscountCodes(priceRuleId: Int) async throws -> DiscountCodesResponse {
        try await networkManager.getDiscountCodes(priceRuleId: priceRuleId)
    }
    
    func createDiscountCode(priceRuleId: Int, discountCode: DiscountCodesRequest) async throws -> DiscountCodesRequest {
        try await networkManager.createDiscountCode(priceRuleId: priceRuleId, discountCode: discountCode)
    }
    
    func deleteDiscountCode(ruleId: Int, codeId: Int) async throws -> Empty {
        try await networkManager.deleteDiscountCode(ruleId: ruleId, codeId: codeId)
    }
    
    func updateDiscountCode(priceRuleId: Int, discountCode: DiscountCodesRequest) async throws -> DiscountCodesRequest {
        try await networkManager.updateDiscountCode(priceRuleId: priceRuleId, discountCode: discountCode)
    }
}
