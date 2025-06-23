//
//  NetworkError.swift
//  Shoplet-Admin
//
//  Created by Macos on 08/06/2025.
//

import Foundation

enum NetworkError: Error, Equatable, LocalizedError {
    case networkUnreachable
    case invalidResponse
    case decodingError
    case serverError(String)
    case other(String)
    
    var errorDescription: String? {
        switch self {
        case .networkUnreachable:
            return "Oops! Something went wrong with the network. Please check your internet connection and try again."
        case .invalidResponse:
            return "Received invalid response from server."
        case .decodingError:
            return "Failed to decode server response."
        case .serverError(let message):
            return message
        case .other(let message):
            return message
        }
    }
}
