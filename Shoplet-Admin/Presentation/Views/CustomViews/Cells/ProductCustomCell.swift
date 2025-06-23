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
        
        VStack(
            alignment: .leading,
            spacing: 10
        ) {
            // Product Title
            Text(
                productTitle
            )
            .font(
                .headline
            )
            .padding(
                .horizontal
            )
            
            HStack(
                alignment: .top,
                spacing: 12
            ) {
                // Product Image
                AsyncImage(
                    url: URL(
                        string: productImageURL
                    )
                ) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(
                                contentMode: .fit
                            )
                            .frame(
                                width: 100,
                                height: 100
                            )
                            .cornerRadius(
                                10
                            )
                    } else if phase.error != nil {
                        Color.red
                            .frame(
                                width: 100,
                                height: 100
                            )
                            .cornerRadius(
                                10
                            )
                    } else {
                        ProgressView()
                            .frame(
                                width: 100,
                                height: 100
                            )
                    }
                }
                
                // Product Details
                VStack(
                    alignment: .leading,
                    spacing: 6
                ) {
                    Text(
                        "\(productPrice)$"
                    )
                    .font(
                        .subheadline
                    )
                    .foregroundColor(
                        .secondary
                    )
                    
                    Text(
                        productCategory
                    )
                    .font(
                        .footnote
                    )
                    .foregroundColor(
                        .gray
                    )
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        // Delete Button
                        Button(action: {
                            print(
                                "delete button pressed"
                            )
                            deleteAction()
                        }) {
                            Image(
                                systemName: "trash"
                            )
                            .foregroundColor(
                                .red
                            )
                            .frame(
                                width: 44,
                                height: 44
                            )
                        }
                        .buttonStyle(
                            PlainButtonStyle()
                        )
                        // Edit Button
                        Button(action: {
                            print(
                                "edit button pressed"
                            )
                            editAction()
                        }) {
                            Image(
                                systemName: "pencil"
                            )
                            .foregroundColor(
                                .blue
                            )
                            .frame(
                                width: 44,
                                height: 44
                            )
                        }
                        .buttonStyle(
                            PlainButtonStyle()
                        )
                    }
                    .padding(
                        .top,
                        10
                    )
                }
            }
        }
        .padding()
        .background(
            Color.white
        )
        .overlay(
            RoundedRectangle(
                cornerRadius: 20
            )
            .stroke(
                Color.green,
                lineWidth: 2
            )
        )
        .cornerRadius(
            20
        )
        .shadow(
            color: .black.opacity(
                0.05
            ),
            radius: 5,
            x: 0,
            y: 2
        )
        .padding(
            .horizontal
        )
        .frame(
            maxWidth: .infinity
        )
    }
}

#Preview {
    ProductCustomCell(
        productTitle: "ADIDAS | CLASSIC BACKPACK | LEGEND INK MULTICOLOUR",
        productPrice: "50.00",
        productCategory: "ACCESSORIES",
        
        productImageURL: "https://cdn.shopify.com/s/files/1/0763/3138/5050/files/product_30_image1.jpg?v=1748773589",
        deleteAction: {
        },
        editAction: {
        }
    )
}
