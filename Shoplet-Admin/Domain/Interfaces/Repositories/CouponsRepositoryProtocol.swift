//
//  DiscountRepositoryProtocol.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation

protocol CouponsRepositoryProtocol {
    func getPriceRules(completion: @escaping (Result<PriceRulesResponse, NetworkError>) -> Void)
    func createPriceRule(priceRule:PriceRuleRequest,completion: @escaping (Result<PriceRuleRequest, NetworkError>) -> Void)
    func deletePriceRule(id:Int,completion: @escaping (Result<Empty, NetworkError>) -> Void)
    func updatePriceRule(priceRule:PriceRuleRequest, completion: @escaping (Result<PriceRuleRequest, NetworkError>) -> Void)
    func getDiscountCodes(priceRuleId:Int,completion: @escaping (Result<DiscountCodesResponse, NetworkError>) -> Void)
    func createDiscountCode(priceRuleId:Int,discountCode:DiscountCodesRequest, completion: @escaping (Result<DiscountCodesRequest, NetworkError>) -> Void)
    func deleteDiscountCode(ruleId: Int, codeId: Int, completion: @escaping (Result<Empty, NetworkError>) -> Void)
    func updateDiscountCode(priceRuleId:Int,discountCode:DiscountCodesRequest, completion: @escaping (Result<DiscountCodesRequest, NetworkError>) -> Void)
}
