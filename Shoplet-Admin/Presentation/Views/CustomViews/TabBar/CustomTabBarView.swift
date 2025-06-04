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
        HStack (alignment: .center){
            tabBarItem(for: .products)
            tabBarItem(for: .priceRules)
            tabBarItem(for: .collections)
        }.frame(height: 82 )
            .ignoresSafeArea(edges: .bottom)
            .tint(Color.blue)
    }
    
    private func tabBarItem(for tab: Tab) -> some View {
        return Button {
            selectedTab = tab
        } label: {
            TabBarButton(tabTitle: tab.title, tabIcon: tab.imageName, isSelected: selectedTab == tab)
        }
        .tint(Color.blue)
    }
}


#Preview {
    CustomTabBarView(selectedTab: .constant(.products))
}
