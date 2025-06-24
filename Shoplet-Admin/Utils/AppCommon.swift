//
//  AppCommon.swift
//  Shoplet-Admin
//
//  Created by Macos on 24/06/2025.
//

import Foundation
import Reachability
import SwiftUI
import Network

class AppCommon: ObservableObject{
    
    public static let shared = AppCommon()

    private let reachability = try! Reachability()
    @Published var networkIsReachable = true

    private init() {
        startMonitoring()
    }

    private func startMonitoring() {
        reachability.whenReachable = { _ in
            print("Network is reachable")
        }
        reachability.whenUnreachable = { _ in
            print("No Network!!")
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    func isNetworkReachable() -> Bool {
        return reachability.connection != .unavailable
    }
}
    
