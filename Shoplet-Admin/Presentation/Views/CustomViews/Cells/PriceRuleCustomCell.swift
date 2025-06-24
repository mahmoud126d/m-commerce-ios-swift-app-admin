//
//  PriceRuleCustomCell.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import SwiftUI

struct PriceRuleCustomCell: View {
    var title: String
    var code: String
    var value: String
    var startDate: String
    var endDate: String
    var deleteAction: () -> Void
    var editAction: () -> Void
    var onTap: () -> Void
    @State private var showDeleteConfirmation = false
    var body: some View {
        let discount = abs(Int(Double(value) ?? 0))

        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.primaryColor.opacity(0.5))
                .frame(height: 140)
                .shadow(radius: 4)

            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)

                    Text("Code: \(code)")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))

                    Text("Value: \(discount)%")
                        .font(.subheadline)
                        .foregroundColor(.red)
                        .bold()

                    Text("Starts at: \(startDate)")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))

                    Text("Ends at: \(endDate)")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
                .onTapGesture {
                    onTap()
                }

                Spacer()

                VStack(spacing: 12) {
                    Button {
                        showDeleteConfirmation = true
                    } label: {
                        Image(systemName: "trash")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                            .background(Color.red.opacity(0.8))
                            .cornerRadius(6)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .alert(isPresented: $showDeleteConfirmation) {
                        Alert(
                            title: Text("Delete Item"),
                            message: Text("Are you sure you want to delete this item?"),
                            primaryButton: .destructive(Text("Delete")) {
                                deleteAction()
                            },
                            secondaryButton: .cancel()
                        )
                    }


                    Button(action: editAction) {
                        Image(systemName: "pencil")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                            .background(Color.primaryColor)
                            .cornerRadius(6)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
        .padding(.horizontal)
    }
}

#Preview {
    PriceRuleCustomCell(
        title: "Summer Sale",
        code: "SUMMER10",
        value: "-10.0",
        startDate: "2025-06-08",
        endDate: "2025-06-09",
        deleteAction: {
            print(
                "Delete tapped"
            )
        },
        editAction: {
            print(
                "Edit tapped"
            )
        },
        onTap: {
            
        }
    )
}


