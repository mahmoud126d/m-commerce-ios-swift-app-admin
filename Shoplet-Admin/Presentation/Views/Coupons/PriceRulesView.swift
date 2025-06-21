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
    @State private var selectedPriceRule: PriceRule?
    @State private var selectedRuleId: Int? = nil
    @State private var isShowingDiscountCodesView = false
    
    var body: some View {
         NavigationView {
            VStack {
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
                                        print("edit button pressed")
                                        print("Setting selectedPriceRule to: \(rule.title ?? "nil")")
                                        self.selectedPriceRule = rule
                                        DispatchQueue.main.async {
                                            print("Opening sheet with selectedPriceRule: \(self.selectedPriceRule?.title ?? "nil")")
                                            self.openAddPriceRuleView = true
                                        }
                                    }
                                )
                                .padding(.vertical, 8)
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)

                                Spacer().frame(height: 10)
                            }
                            .onTapGesture {
                                print("Tapped rule id: \(rule.id ?? 0)")
                                selectedRuleId = rule.id
                                isShowingDiscountCodesView = true
                            }
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
                            .padding(.horizontal)
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                    NavigationLink(
                        destination: DiscountCodesView(viewModel: DIContainer.shared.resolve(DiscountCodeViewModel.self), ruleId: selectedRuleId),
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
            .navigationTitle("Discount Rules")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        openAddPriceRuleView.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $openAddPriceRuleView, onDismiss: {
                selectedPriceRule = nil
            }) {
                AddPriceRuleView(priceRulesViewModel: viewModel, selectedPriceRule: selectedPriceRule)
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
        }

    }
}

#Preview {
    let container = DIContainer.shared
    let viewModel = container.resolve(PriceRulesViewModel.self)

    return PriceRulesView(viewModel: viewModel)
}
