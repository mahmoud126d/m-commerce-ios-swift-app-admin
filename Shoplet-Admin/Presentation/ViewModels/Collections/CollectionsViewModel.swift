//
//  CollectionsViewModel.swift
//  Shoplet-Admin
//
//  Created by Macos on 19/06/2025.
//
import Foundation

@MainActor
class CollectionsViewModel: ObservableObject {
    @Published var collections: [Collection]?
    @Published var isLoading = true
    @Published var userError: NetworkError?
    var selectedCollection: Collection? = nil
    @Published var toastMessage: String? = nil
    
    private let getCollectionsUseCase: GetCollectionsUseCaseProtocol
    private let createCollectionUseCase: CreateCollectionUseCaseProtocol
    private let updateCollectionUseCase: UpdateCollectionUseCaseProtocol
    private let deleteCollectionUseCase: DeleteCollectionUseCaseProtocol
    
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
    
    func createCollection(collectionName: String, collectionImageURL: String, collectionDescription: String) async {
        let collection = CollectionRequest(
            collection: Collection(
                title: collectionName.uppercased(),
                bodyHTML: collectionDescription,
                image: CollectionImage(src: collectionImageURL)
            )
        )
        do {
            let createdCollection = try await createCollectionUseCase.execute(collection: collection)
            userError = nil
            await getCollections()
            self.toastMessage = "Brand created"
        } catch {
            userError = error as? NetworkError
        }
    }
    
    func getCollections() async {
        do {
            let response = try await getCollectionsUseCase.execute()
            userError = nil
            isLoading = false
            collections = response.collections ?? []
        } catch {
            userError = error as? NetworkError
            isLoading = false
        }
    }
    
    func updateCollection(collectionName: String, collectionImageURL: String, collectionDescription: String, collectionId: Int) async {
        let collection = CollectionRequest(
            collection: Collection(
                id: collectionId,
                title: collectionName.uppercased(),
                bodyHTML: collectionDescription,
                image: CollectionImage(src: collectionImageURL)
            )
        )
        do {
            let updatedCollection = try await updateCollectionUseCase.execute(collection: collection)
            userError = nil
            await getCollections()
            self.toastMessage = "Brand updated"
        } catch {
            userError = error as? NetworkError
        }
    }
    
    func deleteCollection(collectionId: Int) async {
        do {
            _ = try await deleteCollectionUseCase.execute(collectionId: collectionId)
            userError = nil
            await getCollections()
            self.toastMessage = "Brand deleted"
        } catch {
            userError = error as? NetworkError
        }
    }
}
