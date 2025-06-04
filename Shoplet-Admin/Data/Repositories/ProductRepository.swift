//
//  ProductRepository.swift
//  Shoplet-Admin
//
//  Created by Macos on 03/06/2025.
//

import Foundation
import Combine

class ProductRepository: ProductRepositoryProtocol {
    
    private let networkManager: NetworkManager

        init(networkManager: NetworkManager = NetworkManager()) {
            self.networkManager = networkManager
        }
        
        func getProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
            networkManager.getProducts { result in
                switch result {
                case .success(let products):
                    completion(.success(products))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    func deleteProduct(productId: Int, completion: @escaping (Result<[Product], Error>) -> Void) {
        networkManager.deleteProduct(id: productId){result in
            switch result {
            case .success(let response):
                //completion(.success(products))
                print(response)
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }
}
