//
//  ProductRepositoryProtocol.swift
//  Shoplet-Admin
//
//  Created by Macos on 03/06/2025.
//

import Foundation
// MARK: - Product Repository Protocol

protocol ProductRepositoryProtocol {
    func getProducts(completion: @escaping (Result<ProductsResponse, NetworkError>) -> Void)
    func deleteProduct(productId:Int,completion: @escaping (Result<Empty, NetworkError>) -> Void)
    func createProduct(product:ProductRequest,completion: @escaping (Result<ProductRequest, NetworkError>) -> Void)
}

