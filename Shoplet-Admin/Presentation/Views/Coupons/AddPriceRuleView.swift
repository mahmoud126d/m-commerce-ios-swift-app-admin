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
    @State private var endDate = Date()
    @State private var ruleTitle: String = ""
    @State private var ruleDiscountValue: String = ""
    let priceRulesViewModel: PriceRulesViewModel
    var selectedPriceRule: PriceRule?
    
    var body: some View {
        NavigationView {
            VStack(
                spacing: 20
            ) {
                Text("Price Rule Details")
                    .bold()
                    .font(.title)
                VStack(
                    spacing: 12
                ) {
                    TextField(
                        "Title",
                        text: $ruleTitle
                    )
                    .textFieldStyle(
                        .roundedBorder
                    )
                    
                    TextField(
                        "Discount",
                        text: $ruleDiscountValue
                    )
                    .textFieldStyle(
                        .roundedBorder
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

                    TextField(
                        "Limit",
                        text: $usageLimit
                    )
                    .textFieldStyle(
                        .roundedBorder
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
            }
            .navigationBarBackButtonHidden(
                false
            )
        }
        .onAppear {
            if selectedPriceRule != nil {
                fillPriceRuleData()
            }
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
        let start = DateFormatterHelper.shared.convertToIsoFormat(
            startDate
        )
        let end = DateFormatterHelper.shared.convertToIsoFormat(
            endDate
        )
        let priceRuleRequest = PriceRuleRequest(
            priceRule: PriceRule(
                id: selectedPriceRule?.id,
                title: ruleTitle,
                valueType: valueType,
                value: self.ruleDiscountValue.contains("-") == true ? "\(ruleDiscountValue)" : "-\(ruleDiscountValue)",
                startsAt: start,
                endsAt: end
            )
        )
        
        if selectedPriceRule == nil {
            priceRulesViewModel.createPriceRule(
                priceRule: priceRuleRequest
            )
        } else {
            priceRulesViewModel.updatePriceRule(
                priceRule: priceRuleRequest
            )
        }
        dismiss()
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
