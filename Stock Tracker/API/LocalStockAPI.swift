//
//  LocalStockAPI.swift
//  Stock Tracker
//
//  Created by Dawson Foushee on 5/20/25.
//

import Foundation

@MainActor
class LocalStockAPI: StockAPI {
    
    nonisolated required init() { }
    
    func fetchStockData() async {
        let fetchedStocks = await loadFromDefaultData()
        
        PersistentStore.shared.saveStocks(fetchedStocks)
    }
    
    private func loadFromDefaultData() async -> [Stock] {
        do {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            
            guard let url = Bundle.main.url(forResource: "default_stock_data", withExtension: "json") else {
                fatalError("Failed to find embedded json file")
            }
            
            let data = try Data(contentsOf: url)
            let stocks = try JSONDecoder().decode([Stock].self, from: data)
            
            print("Loaded local stock data")
            
            return stocks
        } catch {
            print("Failed to load from local JSON")
            return []
        }
    }
}
