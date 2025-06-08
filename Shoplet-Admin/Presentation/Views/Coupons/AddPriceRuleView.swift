//
//  AddPriceRuleView.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import SwiftUI

struct AddPriceRuleView: View {
    @State private var valueType = ValueType.percentage
    @State private var allocationMethod = "Allocation Method"
    @State private var usageLimit: String = ""
    @State private var useCodeOncePerCustomer = false
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var ruleTitle: String = ""
    @State private var ruleDiscountValue: String = ""
    let priceRulesViewModel:PriceRulesViewModel
    
        var body: some View {
            NavigationView {
                VStack(spacing: 20) {
                    Image(systemName: "doc.text").resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .padding(.top)

                    VStack(spacing: 12) {
                        TextField("Title", text: $ruleTitle)
                            .textFieldStyle(.roundedBorder)

                        TextField("Discount", text: $ruleDiscountValue)
                            .textFieldStyle(.roundedBorder)

                        Picker("Value Type", selection: $valueType) {
                            Text("Percentage").tag("Percentage")
                            Text("Fixed").tag("Fixed")
                        }
                        .pickerStyle(.menu)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)

                        Picker("Allocation Method", selection: $allocationMethod) {
                            Text("Each Item").tag("Each Item")
                            Text("Across").tag("Across")
                        }
                        .pickerStyle(.menu)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)

                        TextField("Limit", text: $usageLimit)
                            .textFieldStyle(.roundedBorder)

                        Toggle("Use code once per Customer", isOn: $useCodeOncePerCustomer)

                        DatePicker("Starts At", selection: $startDate, in: Date()..., displayedComponents: .date)
                        DatePicker("Ends At", selection: $endDate, in: startDate..., displayedComponents: .date)
                    }
                    .padding(.horizontal)

                    Spacer()

                    Button(action: {

                        savePriceRule()
                    }) {
                        Text("Save Price Rule Changes")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .navigationBarTitle("Price Rule Details", displayMode: .inline)
                .navigationBarBackButtonHidden(false)
            }
        }
    private func savePriceRule(){
        let start = DateFormatterHelper.shared.convertToIsoFormat(startDate)
        let end = DateFormatterHelper.shared.convertToIsoFormat(endDate)
        let priceRuleRequest = PriceRuleRequest(priceRule: PriceRule(
            title: ruleTitle,
            valueType: valueType.type,
            value: "-\(ruleDiscountValue)",
            startsAt: start,
            endsAt: end
        ))
        priceRulesViewModel.createPriceRule(priceRule: priceRuleRequest)
    }
}

#Preview {
    let repo = CouponsRepository()
    let view = AddPriceRuleView(
        priceRulesViewModel: PriceRulesViewModel(
            getPriceRulesUseCase: GetPriceRulesUseCase(repository: repo),
            createPriceRulesUseCase: CreatePriceRulesUseCase(repository: repo),
            deletePriceRulesUseCase: DeletePriceRulesUseCase(repository: repo),
            updatePriceRulesUseCase: UpdatePriceRulesUseCase(repository: repo)
        )
    )
    return view
}
