//
//  DeleteCollectionUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 19/06/2025.
//

import Foundation

// MARK: - Delete Collections UseCase
protocol DeleteCollectionUseCaseProtocol {
    func execute(collectionId: Int) async throws -> Empty
}

class DeleteCollectionUseCase: DeleteCollectionUseCaseProtocol {
    private let repository: CollectionsRepositoryProtocol
    
    init(repository: CollectionsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(collectionId: Int) async throws -> Empty {
        try await repository.deleteCollection(collectionId: collectionId)
    }
}
