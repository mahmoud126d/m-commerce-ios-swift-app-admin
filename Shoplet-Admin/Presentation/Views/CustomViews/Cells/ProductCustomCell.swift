//
//  ProductCustomCell.swift
//  Shoplet-Admin
//
//  Created by Macos on 04/06/2025.
//

import SwiftUI

struct ProductCustomCell: View {
    let productTitle:String
    let productPrice:String
    let productCategory:String
    let productImageURL:String
    let deleteAction :()->Void
    let editAction:()->Void
    var body: some View {
        
        HStack{
            AsyncImage(url: URL(string: productImageURL)) { phase in
                if let image = phase.image {
                    image.resizable().aspectRatio(contentMode: .fit) // Displays the loaded image.
                } else if phase.error != nil {
                    Color.red // Indicates an error.
                } else {
                    Color.blue // Acts as a placeholder.
                }
            }
            VStack(alignment: .leading) {
                Text(productTitle)
                Text("\(productPrice)$")
                Text(productCategory)
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        print("delete button pressed")
                        deleteAction()
                    }) {
                        SwiftUI.Image(systemName: "trash")
                            .renderingMode(.original)
                            .frame(width: 44, height: 44)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.trailing, 10)

                    Button(action: {
                        print("edit button pressed")
                        editAction()
                    }) {
                        SwiftUI.Image(systemName: "pencil")
                            .renderingMode(.original)
                            .frame(width: 44, height: 44)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(20)
            }

            Spacer()
        }.background(Color.gray).cornerRadius(30.0).frame(height: 150)
    }
}

#Preview {
    ProductCustomCell(
    productTitle: "ADIDAS | CLASSIC BACKPACK | LEGEND INK MULTICOLOUR",
    productPrice: "50.00",
    productCategory: "ACCESSORIES", 
    productImageURL: "https://cdn.shopify.com/s/files/1/0763/3138/5050/files/product_30_image1.jpg?v=1748773589",
    deleteAction: {},
    editAction: {}
    )
}
