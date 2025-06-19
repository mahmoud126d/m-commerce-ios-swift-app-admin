//
//  UpdateCollectionUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 19/06/2025.
//

import Foundation


// MARK: - Update Collection UseCase
protocol UpdateCollectionUseCaseProtocol {
    func execute(collection:CollectionRequest,completion: @escaping (Result<CollectionRequest, NetworkError>) -> Void)
}

class UpdateCollectionUseCase: UpdateCollectionUseCaseProtocol {
    
    private let repository: CollectionsRepositoryProtocol
    
    init(repository: CollectionsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(collection:CollectionRequest,completion: @escaping (Result<CollectionRequest, NetworkError>) -> Void) {
        repository.updateCollection(collection: collection){ result in
            completion(result)
        }
    }
}
