//
//  GetCollectionsUseCase.swift
//  Shoplet-Admin
//
//  Created by Macos on 19/06/2025.
//

import Foundation


// MARK: - Get Collections UseCase
protocol GetCollectionsUseCaseProtocol {
    func execute() async throws -> CollectionsResponse
}

class GetCollectionsUseCase: GetCollectionsUseCaseProtocol {
    private let repository: CollectionsRepositoryProtocol
    
    init(repository: CollectionsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> CollectionsResponse {
        try await repository.getCollections()
    }
}
