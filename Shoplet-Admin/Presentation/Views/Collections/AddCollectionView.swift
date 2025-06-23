//
//  AddCollectionView.swift
//  Shoplet-Admin
//
//  Created by Macos on 19/06/2025.
//

import SwiftUI

import SwiftUI

struct AddCollectionView: View {
    @Environment(\.dismiss) var dismiss
    @State private var collectionTitle: String = ""
    @State private var collectionDescription: String = ""
    @State private var collectionImageUrl: String = ""
    var collection:Collection?
    let collectionsViewModel:CollectionsViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Brand Details")
                    .bold()
                    .font(.title)
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
                    ZStack(alignment: .topTrailing) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 200, height: 200)
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

                        Button(action: {
                            collectionImageUrl = ""
                        }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                                .padding(8)
                                .background(Color.black.opacity(0.6))
                                .clipShape(Circle())
                        }
                        .padding(6)

                        .padding(6)
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
                        dismiss()
                    }
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text(collection == nil ? "Create Collection" : "Update Collection")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryColor)
                    .cornerRadius(12)
                    .padding()
                }
            
                Spacer()
            }
            .onAppear{
                fillFieldsWithCollectionData()
            }
        }
    }
    private func fillFieldsWithCollectionData() {
            guard let collection = collection else { return }
            collectionTitle = collection.title ?? ""
            collectionDescription = collection.bodyHTML ?? ""
            collectionImageUrl = collection.image?.src ?? ""
        }
}


#Preview {
    let viewModel = DIContainer.shared.resolve(CollectionsViewModel.self)
    return AddCollectionView(collectionsViewModel: viewModel)
}
