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
    case discountCodes(priceRuleId: Int)
    case discountCode(priceRuleId: Int, discountCodeId: Int)
    case deleteDiscountCode(priceRuleId: Int, discountCodeId: Int)
    case updateDiscountCode(priceRuleId: Int, discountCodeId: Int)
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
        case .discountCodes(let priceRuleId):
            return "/price_rules/\(priceRuleId)/discount_codes.json"
        case .discountCode(let priceRuleId, let discountCodeId),
             .deleteDiscountCode(let priceRuleId, let discountCodeId),
             .updateDiscountCode(let priceRuleId, let discountCodeId):
            return "/price_rules/\(priceRuleId)/discount_codes/\(discountCodeId).json"
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

