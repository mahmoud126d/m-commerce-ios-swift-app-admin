//
//  GetCollectionsUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 19/06/2025.
//

import Foundation


// MARK: - Get Collections UseCase
protocol GetCollectionsUseCaseProtocol {
    func execute(completion: @escaping (Result<CollectionsResponse, NetworkError>) -> Void)
}

class GetCollectionsUseCase: GetCollectionsUseCaseProtocol {
    
    private let repository: CollectionsRepositoryProtocol
    
    init(repository: CollectionsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(completion: @escaping (Result<CollectionsResponse, NetworkError>) -> Void) {
        repository.getCollections { result in
            completion(result)
        }
    }
}
