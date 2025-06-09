//
//  DiscountCodeCustomCell.swift
//  Shoplet-Admin
//
//  Created by Macos on 09/06/2025.
//

import SwiftUI

struct DiscountCodeCustomCell: View {
        var code: String?
        var deleteAction: () -> Void
        var editAction: () -> Void

        var body: some View {
            HStack {
                Text(code ?? "")
                    .foregroundColor(.white)

                Spacer()
                
//                Button(action: {
//                    editAction()
//                }) {
//                    Image(systemName: "pencil")
//                        .foregroundColor(.white)
//                }
//                .padding(.trailing, 8)
                Button(action: {
                    print("edit button pressed")
                    editAction()
                }) {
                    Image(systemName: "pencil")
                        .foregroundColor(.blue)
                        .frame(width: 44, height: 44)
                }
                .buttonStyle(PlainButtonStyle())
                Button(action: {
                    print("delete button pressed")
                    deleteAction()
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .frame(width: 44, height: 44)
                }.buttonStyle(PlainButtonStyle())  
//                Button(action: {
//                    deleteAction()
//                }) {
//                    Image(systemName: "trash")
//                        .foregroundColor(.red)
//                }
            }
            .padding()
            .background(Color.gray)
            .cornerRadius(8)
        }
}

#Preview {
    DiscountCodeCustomCell(code: "EIDOFF") {
        
    } editAction: {
        
    }

}
