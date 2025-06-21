//
//  AddDiscountCodeView.swift
//  Shoplet-Admin
//
//  Created by Macos on 09/06/2025.
//

import SwiftUI


struct AddDiscountCodeView: View {
    @State private var discountCode: String = ""
    
    let dicountCodesViewModel : DiscountCodeViewModel
    let ruleId : Int
    @Binding var codeId : Int
    @Binding var selectedCode:String
    var body: some View {
        VStack(spacing: 20) {
            Text("Add Discount Code")
                .font(.title)
                .bold()

            TextField("Enter discount code", text: $discountCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Button(action: {
                let dicountCodeRequest = DiscountCodesRequest(discountCode:
                                                                DiscountCode(id: codeId, code: discountCode))
                if selectedCode.isEmpty{
                    dicountCodesViewModel.createDiscountCode(ruleId: ruleId, discountCode: dicountCodeRequest)
                }else{
                    dicountCodesViewModel.updateDiscountCode(ruleId: ruleId, discountCode: dicountCodeRequest)
                }
                
            }) {
                Text((selectedCode.isEmpty) ? "Add" : "Save")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(discountCode.isEmpty ? Color.gray : Color.blue)
                    .cornerRadius(8)
            }
            .disabled(discountCode.isEmpty)
            Spacer()
        }
        .padding()
        .onAppear{
            print("selected code \(selectedCode)")
            print("selected code id \(codeId)")
            discountCode = selectedCode
        }
    }
}

