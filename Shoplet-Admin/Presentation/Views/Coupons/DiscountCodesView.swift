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
    @State private var showToast = false
    @State private var code:String = ""
    @State private var codeId:Int = 0
    var ruleId: Int?
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    showAddSheet = true
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Discount Code")
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
                    ProgressView(
                        "Loading discount codes..."
                    )
                    Spacer()
                } else if let codes = viewModel.discountCodes, !codes.isEmpty {
                    List(
                        codes
                    ) { code in
                        DiscountCodeCustomCell(
                            code: code.code,
                            deleteAction: {
                                Task {
                                    await viewModel.deleteDiscountCode(
                                        ruleId: ruleId ?? 0,
                                        codeId: code.id ?? 0
                                    )
                                }
                                
                            },
                            editAction: {
                                self.code = code.code
                                codeId = code.id ?? 0
                                print(
                                    "code = \(self.code)"
                                )
                                showAddSheet = true
                            }
                        )
                        .listRowSeparator(
                            .hidden
                        )
                    }
                    .listStyle(
                        PlainListStyle()
                    )
                } else {
                    Spacer()
                    Text(
                        "No discount codes found."
                    )
                    .foregroundColor(
                        .gray
                    )
                    Spacer()
                }
            }
            .onAppear {
                if let id = ruleId {
                    Task {
                        await viewModel.getDiscountCodes(
                            ruleId: id
                        )
                    }
                }
            }
            .alert(
                isPresented: $showErrorAlert
            ) {
                Alert(
                    title: Text(
                        "Error"
                    ),
                    message: Text(
                        viewModel.userError?.localizedDescription ?? "An unknown error occurred."
                    ),
                    dismissButton: .default(
                        Text(
                            "OK"
                        )
                    )
                )
            }
            .onChange(
                of: viewModel.userError
            ) { error in
                if error != nil {
                    showErrorAlert = true
                }
            }
            .sheet(
                isPresented: $showAddSheet
            ) {
                AddDiscountCodeView(codeId: $codeId,
                                    selectedCode: $code,
                                    dicountCodesViewModel: viewModel,
                                    ruleId: ruleId ?? 0)
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
    let viewModel = container.resolve(
        DiscountCodeViewModel.self
    )
    
    return DiscountCodesView(
        viewModel: viewModel
    )
}

