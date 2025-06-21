//
//  DiscountRepositoryProtocol.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation

protocol CouponsRepositoryProtocol {
    func getPriceRules() async throws -> PriceRulesResponse
    func createPriceRule(priceRule: PriceRuleRequest) async throws -> PriceRuleRequest
    func deletePriceRule(id: Int) async throws -> Empty
    func updatePriceRule(priceRule: PriceRuleRequest) async throws -> PriceRuleRequest
    func getDiscountCodes(priceRuleId: Int) async throws -> DiscountCodesResponse
    func createDiscountCode(priceRuleId: Int, discountCode: DiscountCodesRequest) async throws -> DiscountCodesRequest
    func deleteDiscountCode(ruleId: Int, codeId: Int) async throws -> Empty
    func updateDiscountCode(priceRuleId: Int, discountCode: DiscountCodesRequest) async throws -> DiscountCodesRequest
}
