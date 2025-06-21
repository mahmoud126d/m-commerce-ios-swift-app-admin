//
//  UpdateCollectionUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 19/06/2025.
//

import Foundation


// MARK: - Update Collection UseCase
protocol UpdateCollectionUseCaseProtocol {
    func execute(collection: CollectionRequest) async throws -> CollectionRequest
}

class UpdateCollectionUseCase: UpdateCollectionUseCaseProtocol {
    private let repository: CollectionsRepositoryProtocol
    
    init(repository: CollectionsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(collection: CollectionRequest) async throws -> CollectionRequest {
        try await repository.updateCollection(collection: collection)
    }
}
