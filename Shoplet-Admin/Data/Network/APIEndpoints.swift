//
//  APIEndpoints.swift
//  Shoplet-Admin
//
//  Created by Macos on 03/06/2025.
//

import Foundation

// MARK: - APIEndpoints
enum APIEndpoints {
    case products
    case product(id: Int)
    case productVariants(productId: Int)
    case productVariant(productId: Int, variantId: Int)
    case inventoryLevels
    case inventoryLevel(inventoryItemId: Int, locationId: Int)
    case discountCodes
    case discountCode(id: Int)
    case priceRules
    case priceRule(id: Int)
    
    var path: String {
        switch self {
        case .products:
            return "/products.json"
        case .product(let id):
            return "/products/\(id).json"
        case .productVariants(let productId):
            return "/products/\(productId)/variants.json"
        case .productVariant(let productId, let variantId):
            return "/products/\(productId)/variants/\(variantId).json"
        case .inventoryLevels:
            return "/inventory_levels.json"
        case .inventoryLevel(let inventoryItemId, let locationId):
            return "/inventory_levels.json?inventory_item_ids=\(inventoryItemId)&location_ids=\(locationId)"
        case .discountCodes:
            return "/discount_codes.json"
        case .discountCode(let id):
            return "/discount_codes/\(id).json"
        case .priceRules:
            return "/price_rules.json"
        case .priceRule(let id):
            return "/price_rules/\(id).json"
        }
    }
    
    var url: String {
        return ShopifyConfig.baseURL + path
    }
}
