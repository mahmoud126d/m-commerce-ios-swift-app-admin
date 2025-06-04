//
//  ProductRepositoryProtocol.swift
//  Shoplet-Admin
//
//  Created by Macos on 03/06/2025.
//

import Foundation
// MARK: - Product Repository Protocol

protocol ProductRepositoryProtocol {
    func getProducts(completion: @escaping (Result<[Product], Error>) -> Void)
    func deleteProduct(productId:Int,completion: @escaping (Result<[Product], Error>) -> Void)
}

