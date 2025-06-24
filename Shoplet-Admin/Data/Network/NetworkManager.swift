//
//  NetworkManager.swift
//  Shoplet-Admin
//
//  Created by Macos on 03/06/2025.
//

import Foundation
import Alamofire
class NetworkManager {
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
        parameters: Parameters? = nil
    ) async throws -> T {
        guard AppCommon.shared.isNetworkReachable() else {
            throw NetworkError.serverError("No Internet Connection")
                }
        let response = await session.request(
            endpoint.url,
            method: method,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        )
        .validate()
        .serializingDecodable(T.self, automaticallyCancelling: true)
        .response

        switch response.result {
        case .success(let data):
            return data

        case .failure(let error):
            if let statusCode = response.response?.statusCode, statusCode == 204 {
                if let emptyData = "{}".data(using: .utf8),
                   let emptyObject = try? JSONDecoder().decode(T.self, from: emptyData) {
                    return emptyObject
                }
                throw NetworkError.serverError("Nothing to decode (204 No Content)")
            }

            guard let data = response.data else {
                throw NetworkError.invalidResponse
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let message = json["message"] as? String {
                    throw NetworkError.serverError(message)
                } else {
                    throw NetworkError.invalidResponse
                }
            } catch {
                throw NetworkError.other(error.localizedDescription)
            }
        }
    }



// MARK: - Product Management
    
    func getProducts() async throws -> ProductsResponse {
        try await request(endpoint: .products)
    }
    
    func deleteProduct(id: Int) async throws -> Empty {
        try await request(endpoint: .product(id: id), method: .delete)
    }
    
    func createProduct(product: ProductRequest) async throws -> ProductRequest {
        let parameters = try encodeToParameters(product)
        return try await request(endpoint: .products, method: .post, parameters: parameters)
    }
    
    func updateProduct(product: ProductRequest) async throws -> ProductRequest {
        let parameters = try encodeToParameters(product)
        return try await request(endpoint: .product(id: product.product.id ?? 0), method: .put, parameters: parameters)
    }
    


// MARK: - Price Rule Management
    
    func getPriceRules() async throws -> PriceRulesResponse {
        try await request(endpoint: .priceRules)
    }
    
    func createPriceRule(rule: PriceRuleRequest) async throws -> PriceRuleRequest {
        let parameters = try encodeToParameters(rule)
        return try await request(endpoint: .priceRules, method: .post, parameters: parameters)
    }
    
    func deletePriceRule(id: Int) async throws -> Empty {
        try await request(endpoint: .priceRule(id: id), method: .delete)
    }
    
    func updatePriceRule(priceRuleRequest: PriceRuleRequest) async throws -> PriceRuleRequest {
        let parameters = try encodeToParameters(priceRuleRequest)
        return try await request(endpoint: .priceRule(id: priceRuleRequest.priceRule.id ?? 0), method: .put, parameters: parameters)
    }


// MARK: - Discount Codes Management
    
    func getDiscountCodes(priceRuleId: Int) async throws -> DiscountCodesResponse {
        try await request(endpoint: .discountCodes(priceRuleId: priceRuleId))
    }
    
    func createDiscountCode(priceRuleId: Int, discountCode: DiscountCodesRequest) async throws -> DiscountCodesRequest {
        let parameters = try encodeToParameters(discountCode)
        return try await request(endpoint: .discountCodes(priceRuleId: priceRuleId), method: .post, parameters: parameters)
    }
    
    func deleteDiscountCode(ruleId: Int, codeId: Int) async throws -> Empty {
        try await request(endpoint: .discountCode(priceRuleId: ruleId, discountCodeId: codeId), method: .delete)
    }
    
    func updateDiscountCode(priceRuleId: Int, discountCode: DiscountCodesRequest) async throws -> DiscountCodesRequest {
        let parameters = try encodeToParameters(discountCode)
        return try await request(endpoint: .discountCode(priceRuleId: priceRuleId, discountCodeId: discountCode.discountCode.id ?? 0), method: .put, parameters: parameters)
    }

// MARK: - Collections Management

    
    func getCollections() async throws -> CollectionsResponse {
        try await request(endpoint: .collections)
    }
    
    func deleteCollection(collectionId: Int) async throws -> Empty {
        try await request(endpoint: .deleteCollection(collectionId: collectionId), method: .delete)
    }
    
    func updateCollection(collection: CollectionRequest) async throws -> CollectionRequest {
        let parameters = try encodeToParameters(collection)
        return try await request(endpoint: .updateCollection(collectionId: collection.collection.id ?? 0), method: .put, parameters: parameters)
    }
    
    func createCollection(collection: CollectionRequest) async throws -> CollectionRequest {
        let parameters = try encodeToParameters(collection)
        return try await request(endpoint: .collections, method: .post, parameters: parameters)
    }
}

// MARK: - Helper
extension NetworkManager {
    private func encodeToParameters<T: Encodable>(_ value: T) throws -> Parameters {
        let data = try JSONEncoder().encode(value)
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw NetworkError.decodingError
        }
        return json
    }
}

struct Empty: Codable {}
