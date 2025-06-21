//
//  ProductRepositoryProtocol.swift
//  Shoplet-Admin
//
//  Created by Macos on 03/06/2025.
//

import Foundation
// MARK: - Product Repository Protocol

protocol ProductRepositoryProtocol {
    func getProducts() async throws -> ProductsResponse
    func deleteProduct(productId:Int) async throws -> Empty
    func createProduct(product:ProductRequest) async throws -> ProductRequest
    func updateProduct(product: ProductRequest) async throws -> ProductRequest
}
