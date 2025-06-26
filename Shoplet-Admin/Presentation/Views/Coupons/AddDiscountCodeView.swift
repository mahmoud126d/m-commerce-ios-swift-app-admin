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
    @State private var showValidationAlert = false
    @State private var validationErrorMessage = ""
    @Binding var codeId : Int
    @Binding var selectedCode: String
    
    let dicountCodesViewModel : DiscountCodeViewModel
    let ruleId : Int
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Discount Code")
                .font(.title)
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
                .onChange(of: discountCode) { newValue in
                    if !newValue.trimmingCharacters(in: .whitespaces).isEmpty {
                        showValidationAlert = false
                    }
                }
            
            Button(action: {
                guard validateDiscountCodeInputs() else {
                    showValidationAlert = true
                    return
                }

                let dicountCodeRequest = DiscountCodesRequest(
                    discountCode: DiscountCode(
                        id: codeId,
                        code: discountCode.trimmingCharacters(in: .whitespaces)
                    )
                )

                Task {
                    if selectedCode.isEmpty {
                        await dicountCodesViewModel.createDiscountCode(
                            ruleId: ruleId,
                            discountCode: dicountCodeRequest
                        )
                    } else {
                        await dicountCodesViewModel.updateDiscountCode(
                            ruleId: ruleId,
                            discountCode: dicountCodeRequest
                        )
                    }
                    dismiss()
                }
            }) {
                Text(selectedCode.isEmpty ? "Add" : "Save")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        discountCode.trimmingCharacters(in: .whitespaces).isEmpty
                            ? Color.gray.opacity(0.6)
                            : Color.primaryColor
                    )
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            
            Spacer()
        }
        .alert("Validation Error", isPresented: $showValidationAlert) {
            Button("OK", role: .cancel) {
            }
        } message: {
            Text(validationErrorMessage)
        }
        .padding(.vertical)
        .onAppear {
            discountCode = selectedCode
        }
    }
    
    private func validateDiscountCodeInputs() -> Bool {
        let trimmedCode = discountCode.trimmingCharacters(in: .whitespaces)
        
        if trimmedCode.isEmpty {
            validationErrorMessage = "Discount code is required."
            return false
        }
        
        if trimmedCode.count < 3 {
            validationErrorMessage = "Discount code must be at least 3 characters long."
            return false
        }
        
        let allowedCharacters = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "-_"))
        if trimmedCode.rangeOfCharacter(from: allowedCharacters.inverted) != nil {
            validationErrorMessage = "Discount code can only contain letters, numbers, hyphens, and underscores."
            return false
        }
        
        return true
    }
}
