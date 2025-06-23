//
//  PriceRulesView.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import SwiftUI

struct PriceRulesView: View {
    @StateObject var viewModel: PriceRulesViewModel
    @State private var showErrorAlert = false
    @State private var openAddPriceRuleView = false
    @State private var selectedRuleId: Int? = nil
    @State private var isShowingDiscountCodesView = false
    @State private var showToast = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    openAddPriceRuleView = true
                    viewModel.selectedPriceRule = nil
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Price Rule")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryColor)
                    .cornerRadius(12)
                    .padding()
                }
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Loading price rules...")
                    Spacer()
                } else if let priceRules = viewModel.priceRuleList, !priceRules.isEmpty {
                    List {
                        ForEach(priceRules) { rule in
                            VStack(spacing: 0) {
                                PriceRuleCustomCell(
                                    title: rule.title ?? "",
                                    code: rule.title ?? "",
                                    value: rule.value ?? "",
                                    startDate: rule.startsAt ?? "",
                                    endDate: rule.endsAt ?? "",
                                    deleteAction: {
                                        viewModel.deletePriceRule(id: rule.id ?? 0)
                                    },
                                    editAction: {
                                        viewModel.selectedPriceRule = rule
                                        self.openAddPriceRuleView = true
                                    },
                                    onTap: {
                                        selectedRuleId = rule.id
                                        isShowingDiscountCodesView = true
                                    }
                                )
                                .padding(.vertical, 8)
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets())

                                .padding(.vertical, 8)
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                                
                                Spacer().frame(height: 10)
                            }
                            .onTapGesture {
                                selectedRuleId = rule.id
                                isShowingDiscountCodesView = true
                            }
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
                        }
                    }
                    .listStyle(PlainListStyle())
                    NavigationLink(
                        destination: DiscountCodesView(
                            viewModel: DIContainer.shared.resolve(DiscountCodeViewModel.self),
                            ruleId: selectedRuleId
                        ),
                        isActive: $isShowingDiscountCodesView,
                        label: { EmptyView() }
                    )
                    .hidden()
                } else {
                    Spacer()
                    Text("No price rules available.")
                        .foregroundColor(.gray)
                    Spacer()
                
                }
            }
            .sheet(isPresented: $openAddPriceRuleView, onDismiss: {
                viewModel.selectedPriceRule = nil
            }) {
                AddPriceRuleView(priceRulesViewModel: viewModel, selectedPriceRule: viewModel.selectedPriceRule)
            }
            .onAppear {
                viewModel.getPriceRules()
            }
            .alert(isPresented: $showErrorAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.userError?.localizedDescription ?? "An unknown error occurred."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .onChange(of: viewModel.userError) { error in
                if error != nil {
                    showErrorAlert = true
                }
            }
            .onChange(of: viewModel.toastMessage) { message in
                if message != nil {
                    withAnimation {
                        showToast = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        viewModel.toastMessage = nil
                    }
                }
            }.toast(isPresented: $showToast, message: viewModel.toastMessage ?? "")
        }
    }
}

#Preview {
    let container = DIContainer.shared
    let viewModel = container.resolve(PriceRulesViewModel.self)
    
    return PriceRulesView(viewModel: viewModel)
}
