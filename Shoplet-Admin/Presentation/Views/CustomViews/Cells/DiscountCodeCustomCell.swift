//
//  DiscountCodeCustomCell.swift
//  Shoplet-Admin
//
//  Created by Macos on 09/06/2025.
//

import SwiftUI

import SwiftUI

struct DiscountCodeCustomCell: View {
    var code: String?
    var deleteAction: () -> Void
    var editAction: () -> Void
    @State private var showDeleteConfirmation = false

    var body: some View {
        ZStack {
            CardShape()
                .fill(Color.primaryColor.opacity(0.4))
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                .frame(height: 100)
            
            HStack(spacing: 16) {
                Image(.sale2)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .padding(.leading, 8)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(code ?? "")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)

                }
                
                Spacer()
                
                Button(action: editAction) {
                    Image(systemName: "pencil")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primaryColor)
                        .frame(width: 36, height: 36)
                }
                .buttonStyle(PlainButtonStyle())
                
                
                Button {
                    showDeleteConfirmation = true
                } label: {
                    Image(systemName: "trash")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.red)
                        .frame(width: 36, height: 36)
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

            }
            .padding(.horizontal)
        }
        .frame(height: 110)
    }
}


struct CardShape: Shape {
    var cornerRadius: CGFloat = 24
    var notchRadius: CGFloat = 18
    
    func path(
        in rect: CGRect
    ) -> Path {
        let centerY = rect.midY
        let notchCenterX = rect.maxX - 1
        
        var path = Path()
        
        path.move(
            to: CGPoint(
                x: cornerRadius,
                y: 0
            )
        )
        
        path.addLine(
            to: CGPoint(
                x: rect.maxX - cornerRadius,
                y: 0
            )
        )
        path.addArc(
            center: CGPoint(
                x: rect.maxX - cornerRadius,
                y: cornerRadius
            ),
            radius: cornerRadius,
            startAngle: .degrees(
                -90
            ),
            endAngle: .degrees(
                0
            ),
            clockwise: false
        )
        path.addLine(
            to: CGPoint(
                x: rect.maxX,
                y: centerY - notchRadius
            )
        )
        path.addArc(
            center: CGPoint(
                x: notchCenterX,
                y: centerY
            ),
            radius: notchRadius,
            startAngle: .degrees(
                -90
            ),
            endAngle: .degrees(
                90
            ),
            clockwise: true
        )
        path.addLine(
            to: CGPoint(
                x: rect.maxX,
                y: rect.maxY - cornerRadius
            )
        )
        path.addArc(
            center: CGPoint(
                x: rect.maxX - cornerRadius,
                y: rect.maxY - cornerRadius
            ),
            radius: cornerRadius,
            startAngle: .degrees(
                0
            ),
            endAngle: .degrees(
                90
            ),
            clockwise: false
        )
        path.addLine(
            to: CGPoint(
                x: cornerRadius,
                y: rect.maxY
            )
        )
        
        path.addArc(
            center: CGPoint(
                x: cornerRadius,
                y: rect.maxY - cornerRadius
            ),
            radius: cornerRadius,
            startAngle: .degrees(
                90
            ),
            endAngle: .degrees(
                180
            ),
            clockwise: false
        )
        path.addLine(
            to: CGPoint(
                x: 0,
                y: cornerRadius
            )
        )
        path.addArc(
            center: CGPoint(
                x: cornerRadius,
                y: cornerRadius
            ),
            radius: cornerRadius,
            startAngle: .degrees(
                180
            ),
            endAngle: .degrees(
                270
            ),
            clockwise: false
        )
        return path
    }
}


#Preview {
    DiscountCodeCustomCell(
        code: "EIDDiscountOFF"
    ) {
        print(
            "Deleted"
        )
    } editAction: {
        print(
            "Edited"
        )
    }
}

