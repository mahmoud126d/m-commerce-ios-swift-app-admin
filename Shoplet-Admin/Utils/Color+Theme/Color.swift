//
//  Color.swift
//  Shoplet-Admin
//
//  Created by Macos on 21/06/2025.
//

import Foundation
import SwiftUI

extension Color {
    static let primaryColor = Color(red: 111/255, green: 79/255, blue: 56/255)
    static let secondaryColor = Color(red: 245/255, green: 235/255, blue: 220/255)
        static func adaptiveBackground(for colorScheme: ColorScheme) -> Color {
            colorScheme == .dark ? Color.primaryColor : .white
        }}

extension Color {
    static func from(name: String) -> Color {
        switch name.lowercased() {
        case "black": return .black
        case "white": return .white
        case "red": return .red
        case "green": return .green
        case "blue": return .blue
        case "yellow": return .yellow
        case "gray": return .gray
        case "orange": return .orange
        case "pink": return .pink
        case "purple": return .purple
        case "brown": return .brown
        default:
            return .gray
        }
    }
}
