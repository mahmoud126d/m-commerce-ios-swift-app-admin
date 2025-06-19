//
//  CollectionsViewModel.swift
//  Shoplet-Admin
//
//  Created by Macos on 19/06/2025.
//

import Foundation

class CollectionsViewModel: ObservableObject{
    @Published var collections:[Collection]?
    @Published var isLoading = true
    @Published var userError: NetworkError? = nil
    
    private let getCollectionsUseCase : GetCollectionsUseCaseProtocol
    private let createCollectionUseCase : CreateCollectionUseCaseProtocol
    private let updateCollectionUseCase : UpdateCollectionUseCaseProtocol
    private let deleteCollectionUseCase : DeleteCollectionUseCaseProtocol
    
    init(
        getCollectionsUseCase: GetCollectionsUseCaseProtocol,
        createCollectionUseCase: CreateCollectionUseCaseProtocol,
        updateCollectionUseCase: UpdateCollectionUseCaseProtocol,
        deleteCollectionUseCase: DeleteCollectionUseCaseProtocol
    ) {
        self.getCollectionsUseCase = getCollectionsUseCase
        self.createCollectionUseCase = createCollectionUseCase
        self.updateCollectionUseCase = updateCollectionUseCase
        self.deleteCollectionUseCase = deleteCollectionUseCase
    }
    func createCollection(collectionName:String,collectionImageURL:String,collectionDescription:String) {
        let collection = CollectionRequest(
            collection: Collection(
                title: collectionName.uppercased(), 
                bodyHTML:collectionDescription,
                image: CollectionImage(src: collectionImageURL)
            )
        )
        createCollectionUseCase.execute(collection: collection) { [weak self] result in
            switch result {
            case .success(let createdCollection):
                self?.userError = nil
                //self?.collections.append(createdCollection.collection)
                print("Collection created: \(createdCollection.collection)")
            case .failure(let error):
                self?.userError = error
                print("Failed to create collection: \(error.localizedDescription)")
            }
        }
    }
    
    func getCollections() {
        getCollectionsUseCase.execute { [weak self] result in
            switch result {
            case .success(let success):
                self?.userError = nil
                self?.isLoading = false
                self?.collections = success.collections ?? []
            case .failure(let failure):
                self?.userError = failure
                self?.isLoading = false
                print(failure.localizedDescription)
            }
        }
    }
    
    func updateCollection(collectionName:String,collectionImageURL:String,collectionDescription:String,collectionId:Int) {
        let collection = CollectionRequest(
            collection: Collection(
                id:collectionId,
                title: collectionName.uppercased(),
                bodyHTML:collectionDescription,
                image: CollectionImage(src: collectionImageURL)
            ))
        updateCollectionUseCase.execute(collection: collection) { [weak self] result in
            switch result {
            case .success(let updatedCollection):
                self?.userError = nil
                self?.getCollections()
                print("Collection updated: \(updatedCollection.collection)")
            case .failure(let error):
                self?.userError = error
                print("Failed to update collection: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteCollection(collectionId: Int) {
        deleteCollectionUseCase.execute(collectionId: collectionId) {[weak self] result in
            switch result {
            case .success:
                self?.userError = nil
                print("Collection Deleted Successfully!")
            case .failure(let error):
                self?.userError = error
                print("Failed to delete collection: \(error.localizedDescription)")
            }
        }
    }
    
}
