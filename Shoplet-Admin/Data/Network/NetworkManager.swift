//
//  NetworkManager.swift
//  Shoplet-Admin
//
//  Created by Macos on 03/06/2025.
//

import Foundation
import Alamofire
class NetworkManager{
    private let session: Session
        
    init() {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 30
            configuration.timeoutIntervalForResource = 60
            self.session = Session(configuration: configuration)
    }
    
    private var headers: HTTPHeaders {
            return [
                "X-Shopify-Access-Token": ShopifyConfig.accessToken,
                "Content-Type": "application/json"
            ]
    }
    
    private func request<T: Codable>(
            endpoint: APIEndpoints,
            method: HTTPMethod = .get,
            parameters: Parameters? = nil,
            completion: @escaping (Result<T, Error>) -> Void
        ) {
            session.request(
                endpoint.url,
                method: method,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: headers
            )
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
}

// MARK: - Product Management
extension NetworkManager {
    
    func getProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
           request(endpoint: .products) { (result: Result<ProductsResponse, Error>) in
               switch result {
               case .success(let response):
                   completion(.success(response.products))
               case .failure(let error):
                   completion(.failure(error))
               }
           }
       }

    func deleteProduct(id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        request(endpoint: .product(id: id),method: .delete) { (result: Result<ProductResponse, Error>) in
            switch result {
            case .success(let response):
                //completion(.success(response.products))
                print(response)
            case .failure(let error):
                completion(.failure(error))
            }
        }
        }
    
}
