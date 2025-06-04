//
//  ProductResponse.swift
//  Shoplet-Admin
//
//  Created by Macos on 03/06/2025.
//

import Foundation

// MARK: - ProductResponse
struct ProductResponse: Codable {
    let product: Product
}
// MARK: - ProductsResponse
struct ProductsResponse: Codable {
    let products: [Product]
}
