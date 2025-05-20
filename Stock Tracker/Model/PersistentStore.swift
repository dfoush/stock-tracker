//
//  PersistentStore.swift
//  Stock Tracker
//
//  Created by Dawson Foushee on 5/19/25.
//

import SwiftData
import Foundation

@MainActor
class PersistentStore {
    
    static let shared = PersistentStore()
    
    var modelContainer: ModelContainer = {
        let schema = Schema([
            Stock.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    func saveStocks(_ stocks: [Stock]) {
        let context = PersistentStore.shared.modelContainer.mainContext
        for stock in stocks {
            if let fetched = try? context.fetch(FetchDescriptor<Stock>(predicate: #Predicate<Stock> { $0.ticker == stock.ticker })).first {
                fetched.update(from:stock)
            } else {
                context.insert(stock)
            }
        }
    }
    
    func getAllStocks() -> [Stock] {
        return try! PersistentStore.shared.modelContainer.mainContext.fetch(FetchDescriptor<Stock>())
    }
    
    func resetData() {
        try? PersistentStore.shared.modelContainer.mainContext.delete(model: Stock.self)
        try? PersistentStore.shared.modelContainer.mainContext.save()
    }
}
