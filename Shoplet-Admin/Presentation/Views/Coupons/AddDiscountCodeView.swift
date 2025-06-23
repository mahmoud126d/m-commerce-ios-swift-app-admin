//
//  AddDiscountCodeView.swift
//  Shoplet-Admin
//
//  Created by Macos on 09/06/2025.
//

import SwiftUI


struct AddDiscountCodeView: View {
    @Environment(\.dismiss) var dismiss
    @State private var discountCode: String = ""
    @Binding var codeId : Int
    @Binding var selectedCode:String
    
    let dicountCodesViewModel : DiscountCodeViewModel
    let ruleId : Int
    
    var body: some View {
        VStack(
            spacing: 20
        ) {
            Text(
                "Add Discount Code"
            )
            .font(
                .title
            )
            .bold()
            
            TextField("Enter discount code", text: $discountCode)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primaryColor, lineWidth: 1.5)
                )
                .padding(.horizontal)

            
            Button(action: {
                let dicountCodeRequest = DiscountCodesRequest(
                    discountCode:
                        DiscountCode(
                            id: codeId,
                            code: discountCode
                        )
                )
                Task{
                    if selectedCode.isEmpty{
                        await dicountCodesViewModel.createDiscountCode(
                            ruleId: ruleId,
                            discountCode: dicountCodeRequest
                        )
                    }else{
                        await dicountCodesViewModel.updateDiscountCode(
                            ruleId: ruleId,
                            discountCode: dicountCodeRequest
                        )
                    }
                    dismiss()
                }
                
            }) {
                Text(
                    (
                        selectedCode.isEmpty
                    ) ? "Add" : "Save"
                )
                .foregroundColor(
                    .white
                )
                .padding()
                .frame(
                    maxWidth: .infinity
                )
                .background(
                    Color.primaryColor
                )
                .cornerRadius(
                    8
                )
            }
            .disabled(
                discountCode.isEmpty
            )
            Spacer()
        }
        .padding()
        .onAppear{
            discountCode = selectedCode
        }
    }
}

