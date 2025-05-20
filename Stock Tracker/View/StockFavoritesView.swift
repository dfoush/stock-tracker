//
//  StockFavoritesView.swift
//  Stock Tracker
//
//  Created by Dawson Foushee on 5/19/25.
//

import SwiftUI
import SwiftData

struct StockFavoritesTab: View {
    
    @State private var sortOrder = SortDescriptor(\Stock.ticker)
    
    var body: some View {
        NavigationStack {
            StockFavoritesView(sort: sortOrder)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu(content: {
                            Picker("Sort", selection: $sortOrder) {
                                Text("Ticker")
                                    .tag(SortDescriptor(\Stock.ticker))

                                Text("Price change increasing")
                                    .tag(SortDescriptor(\Stock.priceChange24Hrs, order: .forward))

                                Text("Price change decreasing")
                                    .tag(SortDescriptor(\Stock.priceChange24Hrs, order: .reverse))
                            }
                            .pickerStyle(.inline)
                        }, label: {
                            Image(systemName: "line.3.horizontal.decrease")
                        })
                    }
                }
        }
    }
}

struct StockFavoritesView: View {
    
    @Query(filter: #Predicate<Stock> { $0.isFavorite },
           sort: \Stock.ticker,
           order: .forward,
           animation: .smooth)
    private var stocks: [Stock]
    
    init(sort: SortDescriptor<Stock>) {
        _stocks = Query(filter: #Predicate<Stock> { $0.isFavorite },
                        sort: [sort],
                        animation: .smooth)
    }

    var body: some View {
        if stocks.isEmpty {
            Text("You don't have any favorites, go add some!")
                .navigationTitle(Text("Favorites"))
        }
        else {
            List {
                ForEach(stocks) { stock in
                    StockRowView(stock: stock)
                }
            }
            .navigationTitle(Text("Favorites"))
        }
    }
}
