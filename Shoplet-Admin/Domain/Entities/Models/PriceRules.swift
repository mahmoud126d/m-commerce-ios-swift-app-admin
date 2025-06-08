//
//  PriceRules.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation

// MARK: - PriceRulesResponse
struct PriceRulesResponse: Codable {
    let priceRules: [PriceRule]?

    enum CodingKeys: String, CodingKey {
        case priceRules = "price_rules"
    }
}

// MARK: - PriceRulesRequest
struct PriceRuleRequest: Codable {
    let priceRule: PriceRule

    enum CodingKeys: String, CodingKey {
        case priceRule = "price_rule"
    }
}

// MARK: - PriceRule
struct PriceRule: Codable, Identifiable {
    let id: Int?
    let title: String?
    let valueType: String?
    let value: String?
    let customerSelection: String?
    let targetType: String?
    let targetSelection: String?
    let allocationMethod: String
    let allocationLimit: Int?
    let oncePerCustomer: Bool?
    let usageLimit: Int?
    let startsAt: String?
    let endsAt: String?
    let createdAt: String?
    let updatedAt: String?
    let entitledProductIDs: [Int]?
    let entitledCollectionIDs: [Int]?
    let entitledCountryIDs: [Int]?
    let prerequisiteProductIDs: [Int]?
    let prerequisiteVariantIDs: [Int]?
    let prerequisiteCollectionIDs: [Int]?
    let customerSegmentPrerequisiteIDs: [Int]?
    let prerequisiteCustomerIDs: [Int]?
    let prerequisiteToEntitlementQuantityRatio: QuantityRatio?
    let prerequisiteToEntitlementPurchase: EntitlementPurchase?

    enum CodingKeys: String, CodingKey {
        case id
        case valueType = "value_type"
        case value
        case customerSelection = "customer_selection"
        case targetType = "target_type"
        case targetSelection = "target_selection"
        case allocationMethod = "allocation_method"
        case allocationLimit = "allocation_limit"
        case oncePerCustomer = "once_per_customer"
        case usageLimit = "usage_limit"
        case startsAt = "starts_at"
        case endsAt = "ends_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case entitledProductIDs = "entitled_product_ids"
        case entitledCollectionIDs = "entitled_collection_ids"
        case entitledCountryIDs = "entitled_country_ids"
        case prerequisiteProductIDs = "prerequisite_product_ids"
        case prerequisiteVariantIDs = "prerequisite_variant_ids"
        case prerequisiteCollectionIDs = "prerequisite_collection_ids"
        case customerSegmentPrerequisiteIDs = "customer_segment_prerequisite_ids"
        case prerequisiteCustomerIDs = "prerequisite_customer_ids"
        case prerequisiteToEntitlementQuantityRatio = "prerequisite_to_entitlement_quantity_ratio"
        case prerequisiteToEntitlementPurchase = "prerequisite_to_entitlement_purchase"
        case title
    }

    // Custom initializer with default values
    init(
        id: Int? = nil,
        title: String,
        valueType: String?,
        value: String,
        customerSelection: String? = "all",
        targetType: String? = "line_item",
        targetSelection: String? = "all",
        allocationMethod: String = "across",
        allocationLimit: Int? = nil,
        oncePerCustomer: Bool? = true,
        usageLimit: Int? = nil,
        startsAt: String? = nil,
        endsAt: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        entitledProductIDs: [Int]? = nil,
        entitledCollectionIDs: [Int]? = nil,
        entitledCountryIDs: [Int]? = nil,
        prerequisiteProductIDs: [Int]? = nil,
        prerequisiteVariantIDs: [Int]? = nil,
        prerequisiteCollectionIDs: [Int]? = nil,
        customerSegmentPrerequisiteIDs: [Int]? = nil,
        prerequisiteCustomerIDs: [Int]? = nil,
        prerequisiteToEntitlementQuantityRatio: QuantityRatio? = nil,
        prerequisiteToEntitlementPurchase: EntitlementPurchase? = nil
    ) {
        self.id = id
        self.title = title
        self.valueType = valueType
        self.value = value
        self.customerSelection = customerSelection
        self.targetType = targetType
        self.targetSelection = targetSelection
        self.allocationMethod = allocationMethod
        self.allocationLimit = allocationLimit
        self.oncePerCustomer = oncePerCustomer
        self.usageLimit = usageLimit
        self.startsAt = startsAt
        self.endsAt = endsAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.entitledProductIDs = entitledProductIDs
        self.entitledCollectionIDs = entitledCollectionIDs
        self.entitledCountryIDs = entitledCountryIDs
        self.prerequisiteProductIDs = prerequisiteProductIDs
        self.prerequisiteVariantIDs = prerequisiteVariantIDs
        self.prerequisiteCollectionIDs = prerequisiteCollectionIDs
        self.customerSegmentPrerequisiteIDs = customerSegmentPrerequisiteIDs
        self.prerequisiteCustomerIDs = prerequisiteCustomerIDs
        self.prerequisiteToEntitlementQuantityRatio = prerequisiteToEntitlementQuantityRatio
        self.prerequisiteToEntitlementPurchase = prerequisiteToEntitlementPurchase
    }
}

// MARK: - QuantityRatio
struct QuantityRatio: Codable {
    let prerequisiteQuantity: Int?
    let entitledQuantity: Int?

    enum CodingKeys: String, CodingKey {
        case prerequisiteQuantity = "prerequisite_quantity"
        case entitledQuantity = "entitled_quantity"
    }
}

// MARK: - EntitlementPurchase
struct EntitlementPurchase: Codable {
    let prerequisiteAmount: Int?

    enum CodingKeys: String, CodingKey {
        case prerequisiteAmount = "prerequisite_amount"
    }
}

enum ValueType: String, CaseIterable {
    case percentage = "Percentage"
    case fixed = "Fixed Amount"

    var type: String {
        switch self {
        case .percentage:
            return "percentage"
        case .fixed:
            return "fixed_amount"
        }
    }
}
