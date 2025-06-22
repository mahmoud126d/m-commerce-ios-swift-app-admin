//
//  TabBarButton.swift
//  Shoplet-Admin
//
//  Created by Macos on 04/06/2025.
//

import SwiftUI

struct TabBarButton: View {
    var icon: String
    var title: String
    var tab: Tab
    @Binding var selectedTab: Tab

    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(selectedTab == tab ? .primaryColor : .gray)
                Text(title)
                    .font(.caption)
                    .foregroundColor(selectedTab == tab ? .primaryColor : .gray)
            }
            .frame(maxWidth: .infinity)
        }
    }
}


//#Preview {
//    TabBarButton(tabTitle: "Products", tabIcon: "ic_products", isSelected: true)
//}
