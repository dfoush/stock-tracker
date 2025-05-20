//
//  StockListTab.swift
//  Stock Tracker
//
//  Created by Dawson Foushee on 5/19/25.
//

import SwiftUI
import SwiftData

struct StockListTab: View {
    
    @Query(sort: \Stock.ticker,
           order: .forward,
           animation: .smooth)
    private var allStocks: [Stock]
    
    @Query(filter: #Predicate<Stock> { $0.isFeatured },
           sort: \Stock.ticker,
           order: .forward,
           animation: .smooth)
    private var featuredStocks: [Stock]

    var body: some View {
        NavigationStack {
            if allStocks.isEmpty {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(2.0, anchor: .center)
            } else {
                List {
                    if (!featuredStocks.isEmpty) {
                        ScrollView(.horizontal) {
                            HStack(spacing: 10, ) {
                                ForEach(featuredStocks) { stock in
                                    StockFeaturedView(stock: stock)
                                        .frame(width: 70, height: 70)
                                        .padding()
                                }
                            }
                        }.scrollIndicators(.hidden)
                    }
                    
                    ForEach(allStocks) { stock in
                        StockRowView(stock: stock)
                    }
                }
                .navigationTitle(Text("Stocks"))
                .refreshable {
                    await DependencyInjection.shared.container.resolve(StockAPI.self)?.fetchStockData()
                }
            }
        }
    }
}
