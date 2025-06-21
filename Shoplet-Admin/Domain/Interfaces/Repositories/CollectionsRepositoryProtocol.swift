//
//  CollectionsRepositoryProtocol.swift
//  Shoplet-Admin
//
//  Created by Macos on 19/06/2025.
//

import Foundation

protocol CollectionsRepositoryProtocol {
    func getCollections() async throws -> CollectionsResponse
    func deleteCollection(collectionId: Int) async throws -> Empty
    func updateCollection(collection: CollectionRequest) async throws -> CollectionRequest
    func createCollection(collection: CollectionRequest) async throws -> CollectionRequest
}
