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
    @State private var productDescriptionTextFieldValue = ""
    @State private var productTagsTextFieldValue = ""
    @State private var productPriceTextFieldValue = ""
    @State private var productSizeTextFieldValue = ""
    @State private var productColorTextFieldValue = ""
    @State private var productQuantityTextFieldValue = ""
    @State private var productImageUrlTextFieldValue = ""
    @State private var productImageUrlsTextFieldValue: [String] = []
    @State private var showValidationAlert = false
    @State private var validationErrorMessage = ""
    @State private var productTypeSegment: ProductType = .shoes
    @State private var selectedVendor: ProductVendor = .nike
    
    private let columns = [
            GridItem(.flexible(), spacing: 10),
            GridItem(.flexible(), spacing: 10),
            GridItem(.flexible(), spacing: 10)
        ]
    
    
    let productViewModel:ProductsViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Product")
                    .bold()
                    .font(.title)
                HStack{
                    Text("Title")
                        .bold()
                    TextField("Product Title", text: $producttitleTextFieldValue)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    
                }.padding()
                HStack {
                    Text("Type: ")
                        .bold()
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
                        .bold()
                    TextField("Product Tags", text: $productTagsTextFieldValue)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    Spacer()
                }.padding()
                HStack {
                    Text("Vendor ")
                        .bold()
                    Menu {
                        ForEach(ProductVendor.allCases) { vendor in
                            Button {
                                selectedVendor = vendor
                            } label: {
                                Label(vendor.rawValue, systemImage: selectedVendor == vendor ? "checkmark" : "")
                            }
                        }
                    } label: {
                        Label(selectedVendor.rawValue, systemImage: "chevron.down")
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                    Spacer()
                }.padding()
                VStack (alignment: .leading){
                    Text("Description")
                        .bold()
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
                        .bold()
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
                    Text("Price $")
                        .bold()
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
                        .bold()
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
                        .bold()
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
                        .bold()
                    TextField("Size", text: $productSizeTextFieldValue)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.horizontal)
                    Spacer()
                }.padding()
                Button(action: {
                    createProduct()
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text(product == nil ? "Create" : "Update")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryColor)
                    .cornerRadius(12)
                }.padding(.horizontal)
                
            }.padding(.vertical)
            .onAppear{
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
            .alert("Validation Error", isPresented: $showValidationAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(validationErrorMessage)
            }

        }
    }
    private func fillFieldsWithProductData() {
        guard let product = product else { return }
        producttitleTextFieldValue = product.title ?? ""
        productDescriptionTextFieldValue = product.description ?? ""
        productTagsTextFieldValue = product.tags ?? ""
        productImageUrlsTextFieldValue = product.images?.compactMap { $0.src } ?? []
        productSizeTextFieldValue = product.options?[0].values?[0] ?? ""
        productColorTextFieldValue = product.options?[1].values?[0] ?? ""
        productQuantityTextFieldValue = "\(String(describing: product.variants?[0].inventoryQuantity ?? 0))"
        productPriceTextFieldValue = product.variants?[0].price ?? ""
    }
    private func createProduct() {
        guard validateInputs() else {
            showValidationAlert = true
            return
        }
        let productImages = productImageUrlsTextFieldValue.map { ProductImageRequest(src: $0) }

        let option1 = Option(id: nil, productId: nil, name: "Color", values: [productColorTextFieldValue])
        let option2 = Option(id: nil, productId: nil, name: "Size", values: [productSizeTextFieldValue])

        let product = ProductRequest(product: Product(
            id: product?.id,
            title: producttitleTextFieldValue,
            description: productDescriptionTextFieldValue,
            vendor: selectedVendor.id,
            productType: productTypeSegment.id,
            tags: productTagsTextFieldValue,
            variants: [
                Variant(
                    price: productPriceTextFieldValue,
                    option1: productColorTextFieldValue,
                    option2: productSizeTextFieldValue,
                    inventoryQuantity: Int(productQuantityTextFieldValue) ?? 0
                )
            ],
            options: [option1, option2],
            images: productImages
        ))

        if self.product == nil {
            productViewModel.createProduct(product: product)
        } else {
            productViewModel.updateProduct(product: product)
        }
        dismiss()
    }

    
    
    private func addUrl() {
        let trimmedUrl = productImageUrlTextFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedUrl.isEmpty else { return }
        productImageUrlsTextFieldValue.append(trimmedUrl)
        productImageUrlTextFieldValue = ""
    }
    private func validateInputs() -> Bool {
        if producttitleTextFieldValue.isEmpty {
            validationErrorMessage = "Product title is required."
            return false
        }
        if productPriceTextFieldValue.isEmpty || Double(productPriceTextFieldValue) == nil {
            validationErrorMessage = "Please enter a valid price."
            return false
        }
        if productQuantityTextFieldValue.isEmpty || Int(productQuantityTextFieldValue) == nil {
            validationErrorMessage = "Please enter a valid quantity."
            return false
        }
        if productColorTextFieldValue.isEmpty {
            validationErrorMessage = "Color is required."
            return false
        }
        if productSizeTextFieldValue.isEmpty {
            validationErrorMessage = "Size is required."
            return false
        }
        return true
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
