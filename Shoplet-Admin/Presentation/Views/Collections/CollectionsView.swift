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
    @State var openAddCollectionView: Bool = false
    @State private var showToast = false
    @State private var showDeleteConfirmation = false
    @State private var selectedCollectionId: Int?
    
    init(viewModel: CollectionsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Button(action: {
                    openAddCollectionView = true
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add New Brand")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryColor)
                    .cornerRadius(12)
                    .padding()
                }

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
                                                    .aspectRatio(1, contentMode: .fit)
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

                                    HStack(spacing: 4) {
                                        Button {
                                            viewModel.selectedCollection = collection
                                            openAddCollectionView = true
                                        } label: {
                                            Image(systemName: "pencil")
                                                .font(.system(size: 16, weight: .semibold))
                                                .foregroundColor(.white)
                                                .frame(width: 32, height: 32)
                                                .background(Color.blue.opacity(0.8))
                                                .cornerRadius(6)
                                        }

                                        Button {
                                            selectedCollectionId = collection.id
                                            showDeleteConfirmation = true
                                        } label: {
                                            Image(systemName: "trash")
                                                .font(.system(size: 16, weight: .semibold))
                                                .foregroundColor(.white)
                                                .frame(width: 32, height: 32)
                                                .background(Color.red.opacity(0.8))
                                                .cornerRadius(6)
                                        }
                                        .alert(isPresented: $showDeleteConfirmation) {
                                            Alert(
                                                title: Text("Delete Collection"),
                                                message: Text("Are you sure you want to delete this collection?"),
                                                primaryButton: .destructive(Text("Delete")) {
                                                    if let id = selectedCollectionId {
                                                        Task {
                                                            await viewModel.deleteCollection(collectionId: id)
                                                        }
                                                    }
                                                },
                                                secondaryButton: .cancel()
                                            )
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .sheet(isPresented: $openAddCollectionView, onDismiss: {
                viewModel.selectedCollection = nil
            }) {
                AddCollectionView(collection: viewModel.selectedCollection, collectionsViewModel: viewModel)
            }
        }
        .onAppear {
            Task{
                await viewModel.getCollections()
            }
        }
        .onChange(of: viewModel.toastMessage) { message in
            if message != nil {
                withAnimation {
                    showToast = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    viewModel.toastMessage = nil
                }
            }
        }
        .toast(isPresented: $showToast, message: viewModel.toastMessage ?? "")
    }
}

#Preview {
    let viewModel = DIContainer.shared.resolve(CollectionsViewModel.self)
    return CollectionsView(viewModel: viewModel)
}
