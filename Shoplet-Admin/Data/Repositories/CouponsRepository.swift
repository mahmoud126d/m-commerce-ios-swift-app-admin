//
//  CouponsRepository.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation

class CouponsRepository: CouponsRepositoryProtocol{

    private let networkManager: NetworkManager

        init(networkManager: NetworkManager = NetworkManager()) {
            self.networkManager = networkManager
        }
    
    func getPriceRules(completion: @escaping (Result<PriceRulesResponse, NetworkError>) -> Void) {
        networkManager.getPriceRules{ result in
            switch result {
            case .success(let priceRules):
                completion(.success(priceRules))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func createPriceRule(priceRule:PriceRuleRequest,completion: @escaping (Result<PriceRuleRequest, NetworkError>) -> Void) {
        networkManager.createPriceRule(rule:priceRule){ result in
            switch result {
            case .success(let priceRules):
                completion(.success(priceRules))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func deletePriceRule(id: Int, completion: @escaping (Result<Empty, NetworkError>) -> Void) {
        networkManager.deletePriceRule(id: id){result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func updatePriceRule(priceRule:PriceRuleRequest, completion: @escaping (Result<PriceRuleRequest, NetworkError>) -> Void) {
        networkManager.updatePriceRule(priceRuleRequest: priceRule){result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func getDiscountCodes(priceRuleId: Int, completion: @escaping (Result<DiscountCodesResponse, NetworkError>) -> Void) {
        networkManager.getDiscountCodes(priceRuleId: priceRuleId){ result in
            switch result {
            case .success(let discountCodes):
                completion(.success(discountCodes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createDiscountCode(priceRuleId: Int, discountCode: DiscountCodesRequest, completion: @escaping (Result<DiscountCodesRequest, NetworkError>) -> Void) {
        networkManager.createDiscountCode(priceRuleId: priceRuleId, discountCode: discountCode){ result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteDiscountCode(ruleId: Int, codeId: Int, completion: @escaping (Result<Empty, NetworkError>) -> Void) {
        networkManager.deleteDiscountCode(ruleId: ruleId, codeId: codeId){result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func updateDiscountCode(priceRuleId: Int, discountCode: DiscountCodesRequest, completion: @escaping (Result<DiscountCodesRequest, NetworkError>) -> Void) {
        networkManager.updateDiscountCode(priceRuleId: priceRuleId, discountCode: discountCode){result in
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
}
