//
//  TabBarButton.swift
//  Shoplet-Admin
//
//  Created by Macos on 04/06/2025.
//

import SwiftUI

struct TabBarButton: View {
    
    var tabTitle: String
    var tabIcon: String
    var isSelected: Bool
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                if isSelected {
                    Rectangle()
                        .foregroundColor(isSelected ? .black : .clear)
                        .frame(width: geo.size.width / 2, height: isSelected ? 3 : 0)
                        .padding(.leading, geo.size.width / 4)

                }

                VStack(alignment: .center, spacing: 4) {
                    SwiftUI.Image(systemName: "star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)

                    Text(tabTitle)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
        }
    }

}

#Preview {
    TabBarButton(tabTitle: "Products", tabIcon: "ic_products", isSelected: true)
}
