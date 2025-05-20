//
//  ContentView.swift
//  Stock Tracker
//
//  Created by Dawson Foushee on 5/19/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    var body: some View {
        TabView {
            StockListTab()
                .tabItem {
                    Label("Stocks", systemImage: "chart.line.uptrend.xyaxis")
                }
            StockFavoritesTab()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Stock.self, inMemory: true)
}
