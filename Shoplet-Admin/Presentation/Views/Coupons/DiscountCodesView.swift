//
//  DiscountCodesView.swift
//  Shoplet-Admin
//
//  Created by Macos on 09/06/2025.
//

import SwiftUI

struct DiscountCodesView: View {
    
    @StateObject var viewModel: DiscountCodeViewModel
    
    @State private var selectedCode: DiscountCode?
    @State private var showEditSheet = false
    @State private var showErrorAlert = false
    @State private var showAddSheet = false
    @State private var code:String = ""
    @State private var codeId:Int = 0
    var ruleId: Int?
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Loading discount codes...")
                    Spacer()
                } else if let codes = viewModel.discountCodes, !codes.isEmpty {
                    List(codes) { code in
                        DiscountCodeCustomCell(
                            code: code.code,
                            deleteAction: {
                                viewModel.deleteDiscountCode(ruleId: ruleId ?? 0, codeId: code.id ?? 0)
                            },
                            editAction: {
                                self.code = code.code
                                codeId = code.id ?? 0
                                print("code = \(self.code)")
                                showAddSheet = true
                            }
                        )
                        .listRowSeparator(.hidden)
                        .padding(.vertical, 4)
                    }
                    .listStyle(PlainListStyle())
                } else {
                    Spacer()
                    Text("No discount codes found.")
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
            .navigationTitle("Discount Codes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                }
            }
            .onAppear {
                if let id = ruleId {
                    viewModel.getDiscountCodes(ruleId: id)
                }
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
            .sheet(isPresented: $showAddSheet) {
                AddDiscountCodeView( dicountCodesViewModel: viewModel, ruleId:ruleId ?? 0 ,codeId: $codeId , selectedCode: $code)
            }

        }
    }
}

#Preview {
    let container = DIContainer.shared
    let viewModel = container.resolve(DiscountCodeViewModel.self)

    return DiscountCodesView(viewModel: viewModel)
}

