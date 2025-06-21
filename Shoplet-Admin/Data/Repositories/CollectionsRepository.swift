//
//  CollectionsRepository.swift
//  Shoplet-Admin
//
//  Created by Macos on 19/06/2025.
//

import Foundation


import Foundation

class CollectionsRepository: CollectionsRepositoryProtocol {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getCollections() async throws -> CollectionsResponse {
        try await networkManager.getCollections()
    }
    
    func deleteCollection(collectionId: Int) async throws -> Empty {
        try await networkManager.deleteCollection(collectionId: collectionId)
    }
    
    func updateCollection(collection: CollectionRequest) async throws -> CollectionRequest {
        try await networkManager.updateCollection(collection: collection)
    }
    
    func createCollection(collection: CollectionRequest) async throws -> CollectionRequest {
        try await networkManager.createCollection(collection: collection)
    }
}
