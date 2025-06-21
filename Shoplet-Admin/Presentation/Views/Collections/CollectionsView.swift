//
//  CollectionsView.swift
//  Shoplet-Admin
//
//  Created by Macos on 19/06/2025.
//

import SwiftUI

struct CollectionsView: View {
    @StateObject private var viewModel: CollectionsViewModel
    @State private var searchText = ""
    @State private var selectedCollection: Collection? = nil
    @State var openAddCollectionView: Bool = false

    init(viewModel: CollectionsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Collections View")
                    .font(.title)
                    .bold()
                    .padding(.horizontal)

                TextField("Search", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)

                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.userError {
                    Text("Error: \(error.localizedDescription)")
                        .foregroundColor(.red)
                        .padding()
                } else if let collections = viewModel.collections {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(collections, id: \.id) { collection in
                                ZStack(alignment: .topTrailing) {
                                    VStack {
                                        if let urlString = collection.image?.src, let imageURL = URL(string: urlString) {
                                            AsyncImage(url: imageURL) { image in
                                                image
                                                    .resizable()
                                                    .aspectRatio(1, contentMode: .fill)
                                                    .frame(maxWidth: .infinity, minHeight: 120, maxHeight: 120)
                                                    .clipped()
                                            } placeholder: {
                                                Color.gray.opacity(0.3)
                                                    .frame(height: 120)
                                            }
                                        }

                                        Text((collection.title ?? "").uppercased())
                                            .font(.subheadline)
                                            .padding(.top, 5)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white)
                                    .cornerRadius(12)
                                    .shadow(radius: 1)

                                    HStack(spacing: 8) {
                                        Button(action: {
                                            selectedCollection = collection
                                            openAddCollectionView = true
                                        }) {
                                            Image(systemName: "pencil.circle.fill")
                                                .foregroundColor(.blue)
                                                .background(Color.white.clipShape(Circle()))
                                        }

                                        Button(action: {
                                            Task{
                                                await viewModel.deleteCollection(collectionId: collection.id ?? 0)
                                            }
                                        }) {
                                            Image(systemName: "trash.fill")
                                                .foregroundColor(.red)
                                                .background(Color.white.clipShape(Circle()))
                                        }
                                    }
                                    .padding([.top, .trailing], 10)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .sheet(isPresented: $openAddCollectionView, onDismiss: {
                selectedCollection = nil
            }) {
                AddCollectionView(collection: selectedCollection, collectionsViewModel: viewModel)
            }
            .navigationBarItems(trailing: Button(action: {
                selectedCollection = nil
                openAddCollectionView.toggle()
            }) {
                Image(systemName: "plus")
            })
        }
        .onAppear {
            Task{
                await viewModel.getCollections()
            }
        }
    }
}
