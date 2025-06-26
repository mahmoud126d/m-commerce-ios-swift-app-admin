//
//  AddPriceRuleView.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import SwiftUI

struct AddPriceRuleView: View {
    @Environment(\.dismiss) var dismiss
    @State private var valueType = "percentage"
    @State private var usageLimit: String = ""
    @State private var useCodeOncePerCustomer = false
    @State private var startDate = Date()
    @State private var endDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    @State private var ruleTitle: String = ""
    @State private var ruleDiscountValue: String = ""
    @State private var showValidationAlert = false
    @State private var validationErrorMessage = ""

    let priceRulesViewModel: PriceRulesViewModel
    var selectedPriceRule: PriceRule?
    
    var body: some View {
        NavigationView {
            VStack(
                spacing: 20
            ) {
                Text("Price Rule")
                    .bold()
                    .font(.title)
                VStack(
                    spacing: 12
                ) {
                    TextField("Title", text: $ruleTitle)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    
                    TextField("Value", text: $ruleDiscountValue)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    TextField("limit", text: $usageLimit)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    Picker(
                        "Value Type",
                        selection: $valueType
                    ) {
                        Text(
                            "Percentage"
                        ).tag(
                            "percentage"
                        )
                        Text(
                            "Fixed"
                        ).tag(
                            "fixed_amount"
                        )
                    }
                    .pickerStyle(
                        .menu
                    )
                    .frame(
                        maxWidth: .infinity
                    )
                    .padding()
                    .background(
                        Color(
                            .systemGray6
                        )
                    )
                    .cornerRadius(
                        8
                    )

                    Toggle(
                        "Use code once per Customer",
                        isOn: $useCodeOncePerCustomer
                    )
                    
                    DatePicker(
                                            "Starts At",
                                            selection: $startDate,
                                            in: Date()...,
                                            displayedComponents: .date
                                        )
                    
                    DatePicker(
                               "Ends At",
                               selection: $endDate,
                               in: startDate...,
                               displayedComponents: .date
                           )
                }
                .padding(
                    .horizontal
                )
                
                Spacer()
                
                Button(action: {
                    savePriceRule()
                }) {
                    Text(
                        (
                            (
                                self.selectedPriceRule
                            ) != nil
                        ) ? "Update Price Rule" : "Create Price Rule"
                    )
                    .foregroundColor(
                        .white
                    )
                    .frame(
                        maxWidth: .infinity
                    )
                    .padding()
                    .background(
                        Color.primaryColor
                    )
                    .cornerRadius(
                        10
                    )
                }
                .padding(
                    .horizontal
                )
                .padding(
                    .bottom
                )
            }.padding(.vertical)
            .navigationBarBackButtonHidden(
                false
            )
        }
        .onAppear {
            if selectedPriceRule != nil {
                fillPriceRuleData()
            }
        }
        .alert("Validation Error", isPresented: $showValidationAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(validationErrorMessage)
        }

    }
    
    private func fillPriceRuleData() {
        guard let rule = selectedPriceRule else {
            return
        }
        
        ruleTitle = rule.title ?? ""
        ruleDiscountValue = rule.value ?? ""
        
        if let startsAtString = rule.startsAt,
           let date = ISO8601DateFormatter().date(
            from: startsAtString
           ) {
            startDate = date
        }
        
        if let endsAtString = rule.endsAt,
           let date = ISO8601DateFormatter().date(
            from: endsAtString
           ) {
            endDate = date
        }
        
        useCodeOncePerCustomer = rule.oncePerCustomer ?? false
        usageLimit = String(
            rule.usageLimit ?? 0
        )
        
        valueType = rule.valueType ?? "percentage"
        
    }
    
    private func savePriceRule() {
        guard validatePriceRuleInputs() else {
            showValidationAlert = true
            return
        }

        let start = DateFormatterHelper.shared.convertToIsoFormat(startDate)
        let end = DateFormatterHelper.shared.convertToIsoFormat(endDate)

        let priceRuleRequest = PriceRuleRequest(
            priceRule: PriceRule(
                id: selectedPriceRule?.id,
                title: ruleTitle,
                valueType: valueType,
                value: ruleDiscountValue.contains("-") ? ruleDiscountValue : "-\(ruleDiscountValue)",
                startsAt: start,
                endsAt: end
            )
        )

        if selectedPriceRule == nil {
            priceRulesViewModel.createPriceRule(priceRule: priceRuleRequest)
        } else {
            priceRulesViewModel.updatePriceRule(priceRule: priceRuleRequest)
        }
        dismiss()
    }

    private func validatePriceRuleInputs() -> Bool {
        if ruleTitle.trimmingCharacters(in: .whitespaces).isEmpty {
            validationErrorMessage = "Title is required."
            return false
        }

        if ruleDiscountValue.trimmingCharacters(in: .whitespaces).isEmpty ||
            Double(ruleDiscountValue) == nil {
            validationErrorMessage = "Enter a valid numeric discount value."
            return false
        }

        if endDate < startDate {
            validationErrorMessage = "End date cannot be earlier than start date."
            return false
        }

        if !usageLimit.isEmpty && Int(usageLimit) == nil {
            validationErrorMessage = "Usage limit must be a valid number."
            return false
        }

        return true
    }

    
}

#Preview {
    let container = DIContainer.shared
    let viewModel = container.resolve(
        PriceRulesViewModel.self
    )

    let view = AddPriceRuleView(
        priceRulesViewModel: viewModel
    )
    return view
}
