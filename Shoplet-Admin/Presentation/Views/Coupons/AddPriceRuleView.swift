//
//  AddPriceRuleView.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import SwiftUI

struct AddPriceRuleView: View {
    @State private var valueType = "percentage"
    @State private var allocationMethod = "across"
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
                Image(
                    systemName: "doc.text"
                ).resizable()
                    .scaledToFit()
                    .frame(
                        height: 150
                    )
                    .padding(
                        .top
                    )
                
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
                    
                    Picker(
                        "Allocation Method",
                        selection: $allocationMethod
                    ) {
                        Text(
                            "Each Item"
                        ).tag(
                            "each"
                        )
                        Text(
                            "Across"
                        ).tag(
                            "across"
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
                        ) ? "Save Price Rule Changes" : "Create Price Rule"
                    )
                    .foregroundColor(
                        .white
                    )
                    .frame(
                        maxWidth: .infinity
                    )
                    .padding()
                    .background(
                        Color.black
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
            .navigationBarTitle(
                "Price Rule Details",
                displayMode: .inline
            )
            .navigationBarBackButtonHidden(
                false
            )
        }
        .onAppear {
            print(
                "🔍 selectedPriceRule title: \(selectedPriceRule?.title ?? "nil")"
            )
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
        
        allocationMethod = rule.allocationMethod
        valueType = rule.valueType ?? "percentage"
        
        print(
            "🔍 After assignment:"
        )
        print(
            "   - valueType State: '\(valueType)'"
        )
        print(
            "   - allocationMethod State: '\(allocationMethod)'"
        )
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
                value: "-\(ruleDiscountValue)",
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
