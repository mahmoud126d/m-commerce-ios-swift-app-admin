//
//  AddProductView.swift
//  Shoplet-Admin
//
//  Created by Macos on 04/06/2025.
//

import SwiftUI
import PhotosUI

struct AddProductView: View {
    @Environment(\.dismiss) var dismiss
    var product:Product?
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []
    @State private var producttitleTextFieldValue = ""
    @State private var productTypeTextFieldValue = ""
    @State private var productVendorTextFieldValue = ""
    @State private var productDescriptionTextFieldValue = ""
    @State private var productTagsTextFieldValue = ""
    @State private var productPriceTextFieldValue = ""
    @State private var productSizeTextFieldValue = ""
    @State private var productColorTextFieldValue = ""
    @State private var productQuantityTextFieldValue = ""
    @State private var productImageUrlTextFieldValue = ""
    @State private var productImageUrlsTextFieldValue: [String] = []
    
    private let columns = [
            GridItem(.flexible(), spacing: 10),
            GridItem(.flexible(), spacing: 10),
            GridItem(.flexible(), spacing: 10)
        ]
    
    @State private var productTypeSegment: ProductType = .shoes
    @State private var selectedLanguage: ProductVendor = .nike
    let productViewModel:ProductsViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                            .foregroundColor(.red)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                    }

                    Spacer()

                    Button(action: {
                        createProduct()
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "plus")
                            Text(product == nil ? "Create" : "Update")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.primaryColor)
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal)

                Text("Product Details")
                    .bold()
                    .font(.title)
                HStack{
                    Text("Title")
                    TextField("Product Title", text: $producttitleTextFieldValue)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.horizontal)

                    
                }.padding()
                HStack {
                    Text("Type: ")
                    Picker("Choose Segment", selection: $productTypeSegment) {
                        ForEach(ProductType.allCases) { segment in
                            Text(segment.rawValue).tag(segment)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Spacer()
                }.padding()
                HStack {
                    Text("Tags")
                    TextField("Product Tags", text: $productTagsTextFieldValue)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.horizontal)

                    Spacer()
                }.padding()
                HStack {
                    Text("Vendor ")
                    Menu {
                        ForEach(ProductVendor.allCases) { language in
                            Button {
                                selectedLanguage = language
                            } label: {
                                Label(language.rawValue, systemImage: selectedLanguage == language ? "checkmark" : "")
                            }
                        }
                    } label: {
                        Label(selectedLanguage.rawValue, systemImage: "chevron.down")
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                    Spacer()
                }.padding()
                VStack (alignment: .leading){
                    Text("Description ")
                    TextEditor(text: $productDescriptionTextFieldValue)
                        .frame(height: 150)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        )
                    Spacer()
                }.padding()
                VStack(alignment: .leading) {
                    Text("Product Images")
                        .font(.headline)
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(productImageUrlsTextFieldValue, id: \.self) { url in
                                    ZStack(alignment: .topTrailing) {
                                        AsyncImage(url: URL(string: url)) { phase in
                                            switch phase {
                                            case .empty:
                                                ProgressView()
                                                    .frame(width: 100, height: 100)
                                                    .background(Color.gray.opacity(0.2))
                                                    .cornerRadius(10)
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 100, height: 100)
                                                    .clipped()
                                                    .cornerRadius(10)
                                            case .failure:
                                                Image(systemName: "photo.badge.exclamationmark")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 100, height: 100)
                                                    .foregroundColor(.red)
                                                    .background(Color.gray.opacity(0.2))
                                                    .cornerRadius(10)
                                            @unknown default:
                                                EmptyView()
                                            }
                                        }

                                        
                                        Button(action: {
                                            if let index = productImageUrlsTextFieldValue.firstIndex(of: url) {
                                                productImageUrlsTextFieldValue.remove(at: index)
                                            }
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.white)
                                                .background(Color.red)
                                                .clipShape(Circle())
                                        }
                                        .offset(x: -5, y: 5)
                                    }
                                }
                            }
                            .padding()
                }
                .padding()
                HStack{
                    TextField("image url", text: $productImageUrlTextFieldValue)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.horizontal)
                    Button(action: {
                        addUrl()
                    }) {
                        HStack {
                            Image(systemName: "plus")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.primaryColor)
                        .cornerRadius(12)
                    }

                }.padding()
                HStack(alignment: .center) {
                    Text("Product Variant ")
                        .bold()
                        .font(.title2)
                }.padding()
                
                HStack {
                    Text("Price ")
                    TextField("Price", text: $productPriceTextFieldValue)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.horizontal)
                    Spacer()
                }.padding()
                HStack {
                    Text("Color")
                    TextField("Color", text: $productColorTextFieldValue)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.horizontal)
                    Spacer()
                }.padding()
                HStack {
                    Text("Quantity")
                    TextField("Quantity", text: $productQuantityTextFieldValue)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.horizontal)
                    Spacer()
                }.padding()
                HStack {
                    Text("Size")
                    TextField("Size", text: $productSizeTextFieldValue)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.horizontal)
                    Spacer()
                }.padding()
                
            }.onAppear{
                fillFieldsWithProductData()
            }
            .onChange(of: selectedItems) { oldItems, newItems in
                Task {
                    selectedImages.removeAll()
                    for item in newItems {
                        if let data = try? await item.loadTransferable(type: Data.self),
                           let image = UIImage(data: data) {
                            selectedImages.append(image)
                        }
                    }
                }
            }
        }
    }
    private func fillFieldsWithProductData() {
        guard let product = product else { return }
        producttitleTextFieldValue = product.title ?? ""
        productTypeTextFieldValue = product.productType ?? ""
        productVendorTextFieldValue = product.vendor ?? ""
        productDescriptionTextFieldValue = product.description ?? ""
        productTagsTextFieldValue = product.tags ?? ""
        productImageUrlsTextFieldValue = product.images?.compactMap { $0.src } ?? []
        productSizeTextFieldValue = product.options?[0].values?[0] ?? ""
        productColorTextFieldValue = product.options?[1].values?[0] ?? ""
        productQuantityTextFieldValue = "\(String(describing: product.variants?[0].inventoryQuantity ?? 0))"
        productPriceTextFieldValue = product.variants?[0].price ?? ""
    }
    private func createProduct() {
        let productImages = productImageUrlsTextFieldValue.map { ProductImageRequest(src: $0) }
        
        let option1 = Option(
            id: nil,
            productId: nil,
            name: "Color",
            values: [productColorTextFieldValue])
        let option2 = Option(
            id: nil,
            productId: nil,
            name: "Size",
            values: [productSizeTextFieldValue])
        let product = ProductRequest(product: Product(
            id:product?.id,
            title: producttitleTextFieldValue,
            description: productDescriptionTextFieldValue,
            vendor: productVendorTextFieldValue,
            productType: productTypeSegment.id,
            tags: productTagsTextFieldValue,
            variants: [Variant(
                price:productPriceTextFieldValue,
                option1: productColorTextFieldValue,
                option2: productSizeTextFieldValue,
                inventoryQuantity: Int(productQuantityTextFieldValue)
                
            )],
            options: [option1,option2],
            images: productImages
        ))
        
        if self.product == nil{
            productViewModel.createProduct(product: product)
        }else{
            productViewModel.updateProduct(product: product)
        }
    }
    
    
    private func addUrl() {
        let trimmedUrl = productImageUrlTextFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedUrl.isEmpty else { return }
        productImageUrlsTextFieldValue.append(trimmedUrl)
        productImageUrlTextFieldValue = ""
    }
    
}



enum ProductType: String, CaseIterable, Identifiable {
    case shoes = "SHOES"
    case accessories = "ACCESSORIES"
    case tShirt = "T-Shirt"
    
    var id: String { self.rawValue }
}

enum ProductVendor: String, CaseIterable, Identifiable {
    case nike = "NIKE"
    case palladium = "PALLADIUM"
    case puma = "PUMA"
    case adidas = "ADIDAS"
    case asicsTiger = "ASICS TIGER"
    case converse = "CONVERSE"
    case flexFit = "FLEX FIT"
    case herschel = "HERSCHEL"
    case supra = "SUPRA"
    case timberland = "TIMBERLAND"
    case vans = "VANS"
    
    var id: String { self.rawValue }
}


#Preview{
    let viewModel = DIContainer.shared.resolve(ProductsViewModel.self)
    return AddProductView(productViewModel: viewModel)
}
