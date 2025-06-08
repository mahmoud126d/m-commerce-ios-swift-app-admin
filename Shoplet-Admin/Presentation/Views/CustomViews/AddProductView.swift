//
//  AddProductView.swift
//  Shoplet-Admin
//
//  Created by Macos on 04/06/2025.
//

import SwiftUI
import PhotosUI

struct AddProductView: View {
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
    
    let productViewModel:ProductsViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(selectedImages, id: \.self) { image in
                            SwiftUI.Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipped()
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
                
                PhotosPicker(
                    selection: $selectedItems,
                    maxSelectionCount: 5,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Text("Select Images")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                    //.cornerRadius(8)
                }
                HStack{
                    Text("Title")
                    TextField("Product Title", text: $producttitleTextFieldValue)
                    
                }.padding()
                HStack {
                    Text("Type: ")
                    TextField("Product Type", text: $productTypeTextFieldValue)
                    Spacer()
                }.padding()
                HStack {
                    Text("Tags ")
                    TextField("Product Tags", text:$productTagsTextFieldValue )
                    Spacer()
                }.padding()
                HStack {
                    Text("Vendor ")
                    TextField("Product Type", text: $productVendorTextFieldValue)
                    Spacer()
                }.padding()
                HStack {
                    Text("Description ")
                    TextField("Product Type", text: $productDescriptionTextFieldValue)
                    Spacer()
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
                Button("Create Product"){
                    createProduct()
                }
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
    func convertImagesToProductImages() -> [ProductImage] {
        let productImages: [ProductImage] = selectedImages.compactMap { image in
            guard let base64String = image.toBase64() else { return nil }
            return ProductImage(
                attachment: base64String,
                alt: "Product Image",
                filename: "product_image.jpg"
            )
        }
        return productImages
    }
    private func createProduct() {
        let base64Images = convertImagesToBase64(selectedImages)
        let productImages = base64Images.map { ProductImageRequest(attachment: $0) }
        let product = ProductRequest(product: Product(
            title: producttitleTextFieldValue, 
            description: productDescriptionTextFieldValue,
            vendor: productVendorTextFieldValue,
            productType: productTypeTextFieldValue,
            tags: productTagsTextFieldValue,
            variants: [Variant(
                price:productPriceTextFieldValue,
                inventoryQuantity: Int(productQuantityTextFieldValue)
                
            )],
            images: productImages
        ))
        
        productViewModel.createProduct(product: product)
    }
    
    func convertImagesToBase64(_ images: [UIImage]) -> [String] {
        return images.compactMap { image in
            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                return nil
            }
            return imageData.base64EncodedString()
        }
    }
    
    
}

#Preview {
    AddProductView(productViewModel: ProductsViewModel(getProductsUseCase: GetProductsUseCase(repository: ProductRepository() ), deleteProductUseCase: DeleteProductsUseCase(repository: ProductRepository()), createProductUseCase: CreateProductsUseCase(repository: ProductRepository())))
}
extension UIImage {
    func toBase64(compressionQuality: CGFloat = 0.8) -> String? {
        guard let imageData = self.jpegData(compressionQuality: compressionQuality) else {
            return nil
        }
        return imageData.base64EncodedString()
    }
}
