//
//  Product.swift
//  Shoplet-Admin
//
//  Created by Macos on 03/06/2025.
//

import Foundation

// MARK: - Product
struct Product: Codable, Identifiable {
    let id: Int?
    let title: String?
    let description: String?
    let vendor: String?
    let productType: String?
    let createdAt: String?
    let updatedAt: String?
    let tags: String?
    let variants: [Variant]?
    let options: [Option]?
    let image: ProductImage?
    var images: [ProductImageRequest]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description = "body_html"
        case vendor
        case productType = "product_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case tags
        case variants
        case options
        case image
        case images
    }
    
    init(id: Int? = nil,
         title: String? = nil,
         description: String? = nil,
         vendor: String? = nil,
         productType: String? = nil,
         createdAt: String? = nil,
         updatedAt: String? = nil,
         tags: String? = nil,
         variants: [Variant]? = nil,
         options: [Option]? = nil,
         image: ProductImage? = nil,
         images: [ProductImageRequest]? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.vendor = vendor
        self.productType = productType
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.tags = tags
        self.variants = variants
        self.options = options
        self.image = image
        self.images = images
    }
}

// MARK: - Variant
struct Variant: Codable {
    let id: Int?
    let productID: Int?
    let title: String?
    let price: String?
    let sku: String?
    let position: Int?
    let inventoryPolicy: String?
    let compareAtPrice: String?
    let fulfillmentService: String?
    let inventoryManagement: String?
    let option1: String?
    let option2: String?
    let option3: String?
    let createdAt: String?
    let updatedAt: String?
    let taxable: Bool?
    let barcode: String?
    let grams: Int?
    let weight: Double?
    let weightUnit: String?
    let inventoryItemID: Int?
    let inventoryQuantity: Int?
    let oldInventoryQuantity: Int?
    let requiresShipping: Bool?
    let adminGraphqlAPIID: String?
    let imageID: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case title, price, sku, position
        case inventoryPolicy = "inventory_policy"
        case compareAtPrice = "compare_at_price"
        case fulfillmentService = "fulfillment_service"
        case inventoryManagement = "inventory_management"
        case option1, option2, option3
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case taxable, barcode, grams, weight
        case weightUnit = "weight_unit"
        case inventoryItemID = "inventory_item_id"
        case inventoryQuantity = "inventory_quantity"
        case oldInventoryQuantity = "old_inventory_quantity"
        case requiresShipping = "requires_shipping"
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case imageID = "image_id"
    }

    init(
        id: Int? = nil,
        productID: Int? = nil,
        title: String? = nil,
        price: String?,
        sku: String? = nil,
        position: Int? = nil,
        inventoryPolicy: String? = nil,
        compareAtPrice: String? = nil,
        fulfillmentService: String? = nil,
        inventoryManagement: String? = nil,
        option1: String? = "1",
        option2: String? = "white",
        option3: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        taxable: Bool? = nil,
        barcode: String? = nil,
        grams: Int? = nil,
        weight: Double? = nil,
        weightUnit: String? = nil,
        inventoryItemID: Int? = nil,
        inventoryQuantity: Int?,
        oldInventoryQuantity: Int? = nil,
        requiresShipping: Bool? = nil,
        adminGraphqlAPIID: String? = nil,
        imageID: Int? = nil
    ) {
        self.id = id
        self.productID = productID
        self.title = title
        self.price = price
        self.sku = sku
        self.position = position
        self.inventoryPolicy = inventoryPolicy
        self.compareAtPrice = compareAtPrice
        self.fulfillmentService = fulfillmentService
        self.inventoryManagement = inventoryManagement
        self.option1 = option1
        self.option2 = option2
        self.option3 = option3
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.taxable = taxable
        self.barcode = barcode
        self.grams = grams
        self.weight = weight
        self.weightUnit = weightUnit
        self.inventoryItemID = inventoryItemID
        self.inventoryQuantity = inventoryQuantity
        self.oldInventoryQuantity = oldInventoryQuantity
        self.requiresShipping = requiresShipping
        self.adminGraphqlAPIID = adminGraphqlAPIID
        self.imageID = imageID
    }
}

// MARK: - Option
struct Option: Codable {
    let id: Int?
    let productId: Int?
    let name: String?
    let values: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case productId = "product_id"
        case name
        case values
    }
}

// MARK: - Image
struct ProductImage: Codable {
    let id: Int?
    let alt: String?
    let position: Int?
    let productID: Int?
    let createdAt: String?
    let updatedAt: String?
    let adminGraphqlAPIID: String?
    let width: Int?
    let height: Int?
    let src: String?
    let variantIDS: [Int]?
    let attachment: String?  // Base64 encoded image data
    let filename: String?    // Optional filename
    
    enum CodingKeys: String, CodingKey {
        case id, alt, position
        case productID = "product_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case width, height, src
        case variantIDS = "variant_ids"
        case attachment 
        case filename
    }

    init(
        id: Int? = nil,
        alt: String? = nil,
        position: Int? = nil,
        productID: Int? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        adminGraphqlAPIID: String? = nil,
        width: Int? = nil,
        height: Int? = nil,
        src: String? = nil,
        variantIDS: [Int]? = nil,
        attachment: String? = nil,
        filename: String? = nil
    ) {
        self.id = id
        self.alt = alt
        self.position = position
        self.productID = productID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.adminGraphqlAPIID = adminGraphqlAPIID
        self.width = width
        self.height = height
        self.src = src
        self.variantIDS = variantIDS
        self.attachment = attachment
        self.filename = filename
    }
    
    // Convenience initializer for creating new images
    init(attachment: String, alt: String? = nil, filename: String? = nil) {
        self.id = nil
        self.alt = alt
        self.position = nil
        self.productID = nil
        self.createdAt = nil
        self.updatedAt = nil
        self.adminGraphqlAPIID = nil
        self.width = nil
        self.height = nil
        self.src = nil
        self.variantIDS = nil
        self.attachment = attachment
        self.filename = filename
    }
}


// MARK: - Helper Extension
extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let encoder = JSONEncoder()
        
        // Configure encoder for nested objects
        encoder.outputFormatting = .prettyPrinted
        
        let data = try encoder.encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        
        guard let dictionary = jsonObject as? [String: Any] else {
            throw EncodingError.invalidValue(self, EncodingError.Context(
                codingPath: [],
                debugDescription: "Failed to convert to dictionary"
            ))
        }
        
        return dictionary
    }
}

struct ProductImageRequest: Codable {
    let attachment: String?  
    
    enum CodingKeys: String, CodingKey {
        case attachment
    }
    
    init(attachment: String?) {
        self.attachment = attachment
    }
}
