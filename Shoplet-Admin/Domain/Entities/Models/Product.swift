//
//  Product.swift
//  Shoplet-Admin
//
//  Created by Macos on 03/06/2025.
//

import Foundation

// MARK: - Product
struct Product : Codable, Identifiable{
    let id:Int?
    let title:String?
    let description:String?
    let vendor:String?
    let productType:String?
    let createdAt:String?
    let updatedAt:String?
    let tags:String?
    let variants:[Variant]?
    let options:[Option]?
    let image:Image?
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
      }
}

// MARK: - Variant
struct Variant: Codable {
    let id: Int?
    let productId: Int?
    let title: String?
    let price: String?
    let option1: String?
    let option2: String?
    let option3: String?
    let createdAt: String?
    let updatedAt: String?
    let grams: Int?
    let weight: Double?
    let weightUnit: String?
    let inventoryQuantity: Int?
    let images: [Image]?

    enum CodingKeys: String, CodingKey {
        case id
        case productId = "product_id"
        case title
        case price
        case option1
        case option2
        case option3
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case grams
        case weight
        case weightUnit = "weight_unit"
        case inventoryQuantity = "inventory_quantity"
        case images
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
struct Image : Codable{
    let id:Int?
    let alt:String?
    let productId:Int?
    let createdAt:String?
    let updatedAt:String?
    let width:Int?
    let height:Int?
    let url:String?
    enum CodingKeys: String, CodingKey {
            case id
            case alt
            case productId = "product_id"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case width
            case height
            case url = "src"
        }
}
