//
//  DateFormatter.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation

class DateFormatterHelper {
    
    static let shared = DateFormatterHelper()
    
    private init() {}
    
    func convertFromIsoFormat(_ dateString: String?) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = inputFormatter.date(from: dateString ?? "") {
            let outputFormatter = DateFormatter()
            outputFormatter.dateStyle = .short
            outputFormatter.timeStyle = .none
            return outputFormatter.string(from: date)
        }
        return dateString
    }
    
    func convertToIsoFormat(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.string(from: date)
    }
    
}
