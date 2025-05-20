//
//  Stock_TrackerApp.swift
//  Stock Tracker
//
//  Created by Dawson Foushee on 5/19/25.
//

import SwiftUI
import SwiftData
import Swinject

@main
struct Stock_TrackerApp: App {
    
    init() {
        DependencyInjection.shared.setup()
        
        Task {
            await DependencyInjection.shared.container.resolve(StockAPI.self)?.fetchStockData()
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(PersistentStore.shared.modelContainer)
    }
}
