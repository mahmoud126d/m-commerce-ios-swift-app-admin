//
//  AddCollectionView.swift
//  Shoplet-Admin
//
//  Created by Macos on 19/06/2025.
//

import SwiftUI

import SwiftUI

struct AddCollectionView: View {
    @State private var collectionTitle: String = ""
    @State private var collectionDescription: String = ""
    @State private var collectionImageUrl: String = ""
    var collection:Collection?
    let collectionsViewModel:CollectionsViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Title", text: $collectionTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                TextField("Description", text: $collectionDescription)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                TextField("Image URL", text: $collectionImageUrl)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                
                if let url = URL(string: collectionImageUrl) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                
                Button(action: {
                    Task{
                        if collection == nil{
                            await collectionsViewModel.createCollection(
                                collectionName: collectionTitle,
                                collectionImageURL: collectionImageUrl,
                                collectionDescription:collectionDescription)
                        }else{
                            await collectionsViewModel.updateCollection(
                                collectionName: collectionTitle,
                                collectionImageURL: collectionImageUrl,
                                collectionDescription:collectionDescription,
                                collectionId: collection?.id ?? 0)
                        }
                    }
                }) {
                    Text(collection == nil ? "Create Collection" : "Update Collection")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.top, 10)

                Spacer()
            }
            .onAppear{
                fillFieldsWithCollectionData()
            }
            .navigationTitle("Collections View")
        }
    }
    private func fillFieldsWithCollectionData() {
            guard let collection = collection else { return }
            collectionTitle = collection.title ?? ""
            collectionDescription = collection.bodyHTML ?? ""
            collectionImageUrl = collection.image?.src ?? ""
        }
}


