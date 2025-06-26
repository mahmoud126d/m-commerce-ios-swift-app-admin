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
    @State private var showValidationAlert = false
    @State private var validationErrorMessage = ""

    var collection:Collection?
    let collectionsViewModel:CollectionsViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Brand Details")
                    .bold()
                    .font(.title)
                    .padding()
                Text("Title")
                    .bold()
                TextField("Title", text: $collectionTitle)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    Text("Description")
                        .bold()
                    TextEditor(text: $collectionDescription)
                        .frame(height: 150)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        )
                Text("Image URL")
                    .bold()
                TextField("Image URL", text: $collectionImageUrl)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
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
                    Task {
                        guard validateCollectionInputs() else {
                            showValidationAlert = true
                            return
                        }
                        
                        if collection == nil {
                            await collectionsViewModel.createCollection(
                                collectionName: collectionTitle,
                                collectionImageURL: collectionImageUrl,
                                collectionDescription: collectionDescription
                            )
                        } else {
                            await collectionsViewModel.updateCollection(
                                collectionName: collectionTitle,
                                collectionImageURL: collectionImageUrl,
                                collectionDescription: collectionDescription,
                                collectionId: collection?.id ?? 0
                            )
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
            }.padding()
            .onAppear{
                fillFieldsWithCollectionData()
            }
            .alert("Validation Error", isPresented: $showValidationAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(validationErrorMessage)
            }
        }
    }
    private func fillFieldsWithCollectionData() {
            guard let collection = collection else { return }
            collectionTitle = collection.title ?? ""
            collectionDescription = collection.bodyHTML ?? ""
            collectionImageUrl = collection.image?.src ?? ""
        }
    private func validateCollectionInputs() -> Bool {
        if collectionTitle.trimmingCharacters(in: .whitespaces).isEmpty {
            validationErrorMessage = "Collection title is required."
            return false
        }

        if collectionDescription.trimmingCharacters(in: .whitespaces).isEmpty {
            validationErrorMessage = "Collection description is required."
            return false
        }

        if collectionImageUrl.trimmingCharacters(in: .whitespaces).isEmpty {
            validationErrorMessage = "Collection image URL is required."
            return false
        }

        if let url = URL(string: collectionImageUrl), url.scheme == "http" || url.scheme == "https" {
        } else {
            validationErrorMessage = "Please enter a valid image URL (http or https)."
            return false
        }

        return true
    }


}


#Preview {
    let viewModel = DIContainer.shared.resolve(CollectionsViewModel.self)
    return AddCollectionView(collectionsViewModel: viewModel)
}
