//
//  CustomTabBarView.swift
//  Shoplet-Admin
//
//  Created by Macos on 03/06/2025.
//

import SwiftUI

struct CustomTabBarView: View {
    @Binding var selectedTab: Tab

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(height: 80)
                .shadow(color: .gray.opacity(0.2), radius: 4, y: -2)

            HStack {
                TabBarButton(icon: "archivebox", title: "Products", tab: .products, selectedTab: $selectedTab)
                
                Spacer()
                
                TabBarButton(icon: "square.stack", title: "Collections", tab: .collections, selectedTab: $selectedTab)
            }
            .padding(.horizontal, 40)
            .padding(.top, 12)
            .padding(.bottom, 10)

            Button(action: {
                selectedTab = .priceRules
            }) {
                VStack {
                    Image(systemName: "tag.fill")
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                    Text("Discount")
                        .font(.caption2)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.primaryColor)
                .clipShape(Circle())
                .shadow(radius: 4)
            }
            .offset(y: -30)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    CustomTabBarView(selectedTab: .constant(.products))
}
