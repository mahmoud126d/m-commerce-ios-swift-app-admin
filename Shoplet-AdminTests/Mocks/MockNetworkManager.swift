//
//  MockNetworkManager.swift
//  Shoplet-AdminTests
//
//  Created by Macos on 28/06/2025.
//

import Foundation
@testable import Shoplet_Admin

class MockNetworkManager: NetworkManagerProtocol {
    
    func getProducts() async throws -> Shoplet_Admin.ProductsResponse {
        let mockProduct = Product(
            id: 1,
            title: "Mock Product",
            description: "This is a mock product for testing.",
            vendor: "Mock Vendor",
            productType: "Mock Type",
            createdAt: "2025-06-28T12:00:00Z",
            updatedAt: "2025-06-28T12:00:00Z",
            tags: "mock, test",
            variants: [],
            options: [],
            image: nil,
            images: nil
        )
        
        let mockResponse = ProductsResponse(products: [mockProduct])
        return mockResponse
    }
    
    func deleteProduct(id: Int) async throws -> Shoplet_Admin.Empty {
        return Shoplet_Admin.Empty()
    }
    
    func createProduct(product: Shoplet_Admin.ProductRequest) async throws -> Shoplet_Admin.ProductRequest {
        return product
    }
    
    func updateProduct(product: Shoplet_Admin.ProductRequest) async throws -> Shoplet_Admin.ProductRequest {
        return product
    }
    
    func getPriceRules() async throws -> Shoplet_Admin.PriceRulesResponse {
        return Shoplet_Admin.PriceRulesResponse(priceRules: [])
    }
    
    func createPriceRule(rule: Shoplet_Admin.PriceRuleRequest) async throws -> Shoplet_Admin.PriceRuleRequest {
        return rule
    }
    
    func deletePriceRule(id: Int) async throws -> Shoplet_Admin.Empty {
        return Shoplet_Admin.Empty()
    }
    
    func updatePriceRule(priceRuleRequest: Shoplet_Admin.PriceRuleRequest) async throws -> Shoplet_Admin.PriceRuleRequest {
        return priceRuleRequest
    }
    
    func getDiscountCodes(priceRuleId: Int) async throws -> Shoplet_Admin.DiscountCodesResponse {
        return Shoplet_Admin.DiscountCodesResponse(discountCodes: [])
    }
    
    func createDiscountCode(priceRuleId: Int, discountCode: Shoplet_Admin.DiscountCodesRequest) async throws -> Shoplet_Admin.DiscountCodesRequest {
        return discountCode
    }
    
    func deleteDiscountCode(ruleId: Int, codeId: Int) async throws -> Shoplet_Admin.Empty {
        return Shoplet_Admin.Empty()
    }
    
    func updateDiscountCode(priceRuleId: Int, discountCode: Shoplet_Admin.DiscountCodesRequest) async throws -> Shoplet_Admin.DiscountCodesRequest {
        return discountCode
    }
    
    func getCollections() async throws -> Shoplet_Admin.CollectionsResponse {
        return Shoplet_Admin.CollectionsResponse(collections: [])
    }
    
    func deleteCollection(collectionId: Int) async throws -> Shoplet_Admin.Empty {
        return Shoplet_Admin.Empty()
    }
    
    func updateCollection(collection: Shoplet_Admin.CollectionRequest) async throws -> Shoplet_Admin.CollectionRequest {
        return collection
    }
    
    func createCollection(collection: Shoplet_Admin.CollectionRequest) async throws -> Shoplet_Admin.CollectionRequest {
        return collection
    }
}
