//
//  NetworkManager.swift
//  Shoplet-Admin
//
//  Created by Macos on 03/06/2025.
//

import Foundation
import Alamofire
class NetworkManager{
    private let session: Session
        
    init() {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 30
            configuration.timeoutIntervalForResource = 60
            self.session = Session(configuration: configuration)
    }
    
    private var headers: HTTPHeaders {
            return [
                "X-Shopify-Access-Token": ShopifyConfig.accessToken,
                "Content-Type": "application/json"
            ]
    }
    
    private func request<T: Codable>(
            endpoint: APIEndpoints,
            method: HTTPMethod = .get,
            parameters: Parameters? = nil,
            completion: @escaping (Result<T, NetworkError>) -> Void
        ) {
        
            session.request(
                endpoint.url,
                method: method,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: headers
            )
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    do {
                        guard let data = response.data else {
                            completion(.failure(.invalidResponse))
                            return
                        }
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if (json as? [String: Any])?["Message"] is String {
                            completion(.failure(.decodingError))
                        } else {
                            completion(.failure(.serverError(error.localizedDescription)))
                        }
                    } catch {
                        completion(.failure(.other(error.localizedDescription)))
                    }
                    break
                }
            }
        }
}

// MARK: - Product Management
extension NetworkManager {
    
    func getProducts(completion: @escaping (Result<ProductsResponse, NetworkError>) -> Void) {
        request(endpoint: .products) { (result: Result<ProductsResponse, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteProduct(id: Int, completion: @escaping (Result<Empty, NetworkError>) -> Void) {
        request(endpoint: .product(id: id),method: .delete) { (result: Result<Empty, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
                print(response)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createProduct(product: ProductRequest, completion: @escaping (Result<ProductRequest, NetworkError>) -> Void) {
        do {
            let parameters: Parameters = try (JSONSerialization.jsonObject(with: JSONEncoder().encode(product)) as? [String: Any])!
            print("json is \(parameters)")
            request(endpoint: .products, method: .post, parameters: parameters) { (result: Result<ProductRequest, NetworkError>) in
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    print("Error details: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        } catch {
            //completion(.failure(error))
        }
    }
}

struct Empty : Codable{}

// MARK: - Price Rule Management
extension NetworkManager {
    func getPriceRules(completion: @escaping (Result<PriceRulesResponse, NetworkError>) -> Void) {
        request(endpoint: .priceRules) { (result: Result<PriceRulesResponse, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func createPriceRule(rule: PriceRuleRequest, completion: @escaping (Result<PriceRuleRequest, NetworkError>) -> Void) {
        do {
            let parameters: Parameters = try (JSONSerialization.jsonObject(with: JSONEncoder().encode(rule)) as? [String: Any])!
            request(endpoint: .priceRules, method: .post, parameters: parameters) { (result: Result<PriceRuleRequest, NetworkError>) in
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    print("Error details: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        } catch {
            //completion(.failure(error))
        }
    }
    func deletePriceRule(id: Int, completion: @escaping (Result<Empty, NetworkError>) -> Void) {
        request(endpoint: .priceRule(id: id),method: .delete) { (result: Result<Empty, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func updatePriceRule(priceRuleRequest: PriceRuleRequest, completion: @escaping (Result<PriceRuleRequest, NetworkError>) -> Void) {
            do {
                let parameters: Parameters = try (JSONSerialization.jsonObject(with: JSONEncoder().encode(priceRuleRequest)) as? [String: Any])!
                request(endpoint: .priceRule(id: priceRuleRequest.priceRule.id ?? 0), method: .put, parameters: parameters) { (result: Result<PriceRuleRequest, NetworkError>) in
                    switch result {
                    case .success(let response):
                        completion(.success(response))
                    case .failure(let error):
                        print("Error details: \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                }
            } catch {
                //completion(.failure(error))
            }
    }
}
// MARK: - Discount Codes Management

extension NetworkManager{
    func getDiscountCodes(priceRuleId:Int,completion: @escaping (Result<DiscountCodesResponse, NetworkError>) -> Void) {
        request(endpoint: .discountCodes(priceRuleId: priceRuleId)) { (result: Result<DiscountCodesResponse, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func createDiscountCode(priceRuleId:Int,discountCode:DiscountCodesRequest, completion: @escaping (Result<DiscountCodesRequest, NetworkError>) -> Void) {
        do {
            let parameters: Parameters = try (JSONSerialization.jsonObject(with: JSONEncoder().encode(discountCode)) as? [String: Any])!
            print(parameters)
            request(endpoint: .discountCodes(priceRuleId: priceRuleId), method: .post, parameters: parameters) { (result: Result<DiscountCodesRequest, NetworkError>) in
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    print("Error details: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        } catch {
            //completion(.failure(error))
        }
    }
    func deleteDiscountCode(ruleId: Int, codeId: Int, completion: @escaping (Result<Empty, NetworkError>) -> Void) {
        request(endpoint: .discountCode(priceRuleId: ruleId, discountCodeId: codeId),method: .delete) { (result: Result<Empty, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func updateDiscountCode(priceRuleId:Int,discountCode:DiscountCodesRequest, completion: @escaping (Result<DiscountCodesRequest, NetworkError>) -> Void) {
            do {
                let parameters: Parameters = try (JSONSerialization.jsonObject(with: JSONEncoder().encode(discountCode)) as? [String: Any])!
                request(endpoint: .discountCode(priceRuleId: priceRuleId, discountCodeId: discountCode.discountCode.id ?? 0), method: .put, parameters: parameters) { (result: Result<DiscountCodesRequest, NetworkError>) in
                    switch result {
                    case .success(let response):
                        completion(.success(response))
                    case .failure(let error):
                        print("Error details: \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                }
            } catch {
                //completion(.failure(error))
            }
    }
}
