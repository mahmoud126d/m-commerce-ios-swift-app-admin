//
//  Tab.swift
//  Shoplet-Admin
//
//  Created by Macos on 04/06/2025.
//

import SwiftUI


enum Tab: Int {
    case products
    case collections
    case priceRules
    
    var title: String {
            switch self {
            case .products: return "Products"
            case .collections: return "Collections"
            case .priceRules: return "Price Rules"
            }
        }
    
        var imageName: String {
            switch self {
            case .products: return "ic_products"
            case .collections: return "ic_collections"
            case .priceRules: return "ic_coupons"
            }
        }
}
