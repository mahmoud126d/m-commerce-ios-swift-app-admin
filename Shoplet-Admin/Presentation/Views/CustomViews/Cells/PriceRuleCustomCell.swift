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
        let discount = abs(
            Int(
                Double(
                    value
                ) ?? 0
            )
        )
        
        ZStack {
            RoundedRectangle(
                cornerRadius: 20
            )
            .fill(
                Color.primaryColor.opacity(
                    0.5
                )
            )
            .frame(
                height: 140
            )
            .shadow(
                radius: 4
            )
            
            HStack(
                alignment: .top
            ) {
                VStack(
                    alignment: .leading,
                    spacing: 6
                ) {
                    Text(
                        title
                    )
                    .font(
                        .headline
                    )
                    .foregroundColor(
                        .white
                    )
                    
                    Text(
                        "Code: \(code)"
                    )
                    .font(
                        .subheadline
                    )
                    .foregroundColor(
                        .white.opacity(
                            0.9
                        )
                    )
                    
                    Text(
                        "Value: \(discount)%"
                    )
                    .font(
                        .subheadline
                    )
                    .foregroundColor(
                        .green
                    )
                    .bold()
                    
                    Text(
                        "Starts at: \(startDate)"
                    )
                    .font(
                        .caption
                    )
                    .foregroundColor(
                        .white.opacity(
                            0.8
                        )
                    )
                    
                    Text(
                        "Ends at: \(endDate)"
                    )
                    .font(
                        .caption
                    )
                    .foregroundColor(
                        .white.opacity(
                            0.8
                        )
                    )
                }
                
                Spacer()
                
                VStack(
                    spacing: 12
                ) {
                    Button(action: {
                        deleteAction()
                    }) {
                        Image(
                            systemName: "trash"
                        )
                        .foregroundColor(
                            .red
                        )
                        .frame(
                            width: 44,
                            height: 44
                        )
                    }
                    .buttonStyle(
                        PlainButtonStyle()
                    )
                    
                    Button(action: {
                        editAction()
                    }) {
                        Image(
                            systemName: "pencil"
                        )
                        .foregroundColor(
                            .primaryColor
                        )
                        .frame(
                            width: 44,
                            height: 44
                        )
                    }
                    .buttonStyle(
                        PlainButtonStyle()
                    )
                }
            }
            .padding()
        }
        .padding(
            .horizontal
        )
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
        }
    )
}


