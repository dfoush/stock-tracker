//
//  RemoteStockAPI.swift
//  Stock Tracker
//
//  Created by Dawson Foushee on 5/20/25.
//

import Foundation

@MainActor
class RemoteStockAPI: StockAPI {
    
    nonisolated required init() { }
    
    func fetchStockData() async {
        let fetchedStocks = await loadFromRemoteData()
        
        PersistentStore.shared.saveStocks(fetchedStocks)
    }
    
    private func loadFromRemoteData() async -> [Stock] {
        do {
            guard let url = URL(string: "https://raw.githubusercontent.com/dfoush/stock-tracker/refs/heads/main/Stock%20Tracker/Resources/default_stock_data.json") else {
                fatalError("Failed to create URL")
            }
            
            let result = try await URLSession.shared.data(from: url)
            let stocks = try JSONDecoder().decode([Stock].self, from: result.0)
            
            print("Loaded remote stock data")
            
            return stocks
        } catch {
            print("Failed to load from remote JSON")
            return []
        }
    }
}
