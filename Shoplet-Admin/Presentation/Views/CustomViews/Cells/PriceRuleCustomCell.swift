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

        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text("Code: \(code)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text("Value: \(value)")
                            .font(.subheadline)
                            .foregroundColor(.green)
                        
                        Text("Starts at: \(startDate)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("Ends at: \(endDate)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()

                    HStack(spacing: 10) {
                        Button(action: editAction) {
                            Image(systemName: "pencil")
                                .foregroundColor(.blue)
                        }

                        Button(action: deleteAction) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(12)
                .shadow(color: .gray.opacity(0.1), radius: 4, x: 0, y: 2)
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
            print("Delete tapped")
        },
        editAction: {
            print("Edit tapped")
        }
    )
}

