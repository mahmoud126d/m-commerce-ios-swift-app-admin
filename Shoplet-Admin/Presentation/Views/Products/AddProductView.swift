//
//  AddProductView.swift
//  Shoplet-Admin
//
//  Created by Macos on 04/06/2025.
//

import SwiftUI
import PhotosUI

struct AddProductView: View {
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

    
    
    @State private var productTypeSegment: ProductType = .first
    @State private var selectedLanguage: ProductVendor = .swift
    let productViewModel:ProductsViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Product Details")
                HStack{
                    Text("Title")
                    TextField("Product Title", text: $producttitleTextFieldValue)
                    
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
                    Text("Tags ")
                    TextField("Product Tags", text:$productTagsTextFieldValue )
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
                HStack {
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
                    
                    ForEach(productImageUrlsTextFieldValue, id: \.self) { url in
                        HStack {
                            AsyncImage(url: URL(string: url)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 60, height: 60)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                case .failure:
                                    Image(systemName: "photo.badge.exclamationmark")
                                        .foregroundColor(.red)
                                        .frame(width: 60, height: 60)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            
                            Text(url)
                                .font(.caption)
                                .lineLimit(1)
                            
                            Spacer()
                            
                            Button("Remove") {
                                if let index = productImageUrlsTextFieldValue.firstIndex(of: url) {
                                    productImageUrlsTextFieldValue.remove(at: index)
                                }
                            }
                            .foregroundColor(.red)
                        }
                        .padding(.vertical, 4)
                    }
                }
                .padding()
                HStack{
                    TextField("image url", text: $productImageUrlTextFieldValue)
                    Button("add"){
                        addUrl()
                        print(productImageUrlsTextFieldValue)
                    }
                }.padding()
                HStack(alignment: .center) {
                    Text("Product Variant ")
                }.padding()

                HStack {
                    Text("Price ")
                    TextField("Product Type", text: $productPriceTextFieldValue)
                    Spacer()
                }.padding()
                HStack {
                    Text("Color ")
                    TextField("Product Type", text: $productColorTextFieldValue)
                    Spacer()
                }.padding()
                HStack {
                    Text("Quantity ")
                    TextField("Product Type", text: $productQuantityTextFieldValue)
                    Spacer()
                }.padding()
                HStack {
                    Text("Size ")
                    TextField("Product Type", text: $productSizeTextFieldValue)
                    Spacer()
                }.padding()
                Spacer()
                Button(product == nil ? "Create Product" : "Update Product"){
                    createProduct()
                }
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

//#Preview {
//    AddProductView(productViewModel: ProductsViewModel(getProductsUseCase: GetProductsUseCase(repository: ProductRepository() ), deleteProductUseCase: DeleteProductsUseCase(repository: ProductRepository()), createProductUseCase: CreateProductsUseCase(repository: ProductRepository()), updateProductUseCase: UpdateProductUseCase(repository: ProductRepository())))
//}


enum ProductType: String, CaseIterable, Identifiable {
    case first = "SHOES"
    case second = "ACCESSORIES"
    case third = "T-Shirt"

    var id: String { self.rawValue }
}

enum ProductVendor: String, CaseIterable, Identifiable {
    case swift = "NIKE"
    case kotlin = "PALLADIUM"
    case java = "PUMA"
    
    var id: String { self.rawValue }
}
