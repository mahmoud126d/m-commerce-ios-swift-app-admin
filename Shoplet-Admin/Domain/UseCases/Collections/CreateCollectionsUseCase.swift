//
//  CreateCollectionsUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 19/06/2025.
//

import Foundation

// MARK: - Create Collections UseCase
protocol CreateCollectionUseCaseProtocol {
    func execute(collection: CollectionRequest) async throws -> CollectionRequest
}

class CreateCollectionUseCase: CreateCollectionUseCaseProtocol {
    
    private let repository: CollectionsRepositoryProtocol
    
    init(repository: CollectionsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(collection: CollectionRequest) async throws -> CollectionRequest {
        try await repository.createCollection(collection: collection)
    }
}
