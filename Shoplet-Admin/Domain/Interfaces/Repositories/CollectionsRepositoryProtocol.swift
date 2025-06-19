//
//  CollectionsRepositoryProtocol.swift
//  Shoplet-Admin
//
//  Created by Macos on 19/06/2025.
//

import Foundation

protocol CollectionsRepositoryProtocol{
    func getCollections(completion: @escaping (Result<CollectionsResponse, NetworkError>) -> Void)
    func deleteCollection(collectionId: Int, completion: @escaping (Result<Empty, NetworkError>) -> Void)
    func updateCollection(collection: CollectionRequest, completion: @escaping (Result<CollectionRequest, NetworkError>) -> Void)
    func createCollection(collection: CollectionRequest, completion: @escaping (Result<CollectionRequest, NetworkError>) -> Void)
}
