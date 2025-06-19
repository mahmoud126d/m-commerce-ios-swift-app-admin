//
//  CollectionsRepository.swift
//  Shoplet-Admin
//
//  Created by Macos on 19/06/2025.
//

import Foundation


class CollectionsRepository: CollectionsRepositoryProtocol{
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getCollections(completion: @escaping (Result<CollectionsResponse, NetworkError>) -> Void) {
        networkManager.getCollections{ result in
            switch result {
            case .success(let collections):
                completion(.success(collections))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteCollection(collectionId: Int, completion: @escaping (Result<Empty, NetworkError>) -> Void) {
        networkManager.deleteCollection(collectionId: collectionId){ result in
            switch result {
            case .success(let collections):
                completion(.success(collections))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateCollection(collection: CollectionRequest, completion: @escaping (Result<CollectionRequest, NetworkError>) -> Void) {
        networkManager.updateCollection(collection: collection){ result in
            switch result {
            case .success(let collections):
                completion(.success(collections))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createCollection(collection: CollectionRequest, completion: @escaping (Result<CollectionRequest, NetworkError>) -> Void) {
        networkManager.createCollection(collection: collection){ result in
            switch result {
            case .success(let collections):
                completion(.success(collections))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
