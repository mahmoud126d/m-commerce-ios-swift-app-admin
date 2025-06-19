//
//  CreateCollectionsUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 19/06/2025.
//

import Foundation

// MARK: - Create Collections UseCase
protocol CreateCollectionUseCaseProtocol {
    func execute(collection:CollectionRequest,completion: @escaping (Result<CollectionRequest, NetworkError>) -> Void)
}

class CreateCollectionUseCase: CreateCollectionUseCaseProtocol {
    
    private let repository: CollectionsRepositoryProtocol
    
    init(repository: CollectionsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(collection:CollectionRequest,completion: @escaping (Result<CollectionRequest, NetworkError>) -> Void) {
        repository.createCollection(collection: collection) { result in
            completion(result)
        }
    }
}
