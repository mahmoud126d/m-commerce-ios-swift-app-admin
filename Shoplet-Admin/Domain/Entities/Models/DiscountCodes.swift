//
//  DiscountCodes.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation

import Foundation

struct DiscountCodesResponse: Codable {
    let discountCodes: [DiscountCode]?
    
    enum CodingKeys: String, CodingKey {
        case discountCodes = "discount_codes"
    }
}
struct DiscountCodesRequest: Codable {
    let discountCode: DiscountCode
    
    enum CodingKeys: String, CodingKey {
        case discountCode = "discount_code"
    }
}

struct DiscountCode: Codable, Identifiable {
    let id: Int?
    let priceRuleId: Int?
    let code: String
    let usageCount: Int?
    let createdAt: String?
    let updatedAt: String?
    
    init(id: Int? = nil, priceRuleId: Int? = nil, code: String, usageCount: Int? = nil, createdAt: String? = nil, updatedAt: String? = nil) {
        self.id = id
        self.priceRuleId = priceRuleId
        self.code = code
        self.usageCount = usageCount
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    enum CodingKeys: String, CodingKey {
        case id
        case priceRuleId = "price_rule_id"
        case code
        case usageCount = "usage_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - DiscountCodeCreationResponse
//struct DiscountCodeCreationResponse: Codable {
//    let discountCodeCreation: DiscountCodeCreation
//    
//    enum CodingKeys: String, CodingKey {
//        case discountCodeCreation = "discount_code_creation"
//    }
//}


struct DiscountCodeCreation: Codable {
    let id: Int
    let priceRuleID: Int
    let startedAt: String?
    let completedAt: String?
    let createdAt: String
    let updatedAt: String
    let status: String
    let codesCount: Int
    let importedCount: Int
    let failedCount: Int
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case priceRuleID = "price_rule_id"
        case startedAt = "started_at"
        case completedAt = "completed_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case status
        case codesCount = "codes_count"
        case importedCount = "imported_count"
        case failedCount = "failed_count"
      
    }
}
