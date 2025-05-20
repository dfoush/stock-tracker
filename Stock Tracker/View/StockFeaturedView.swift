//
//  StockFeaturedView.swift
//  Stock Tracker
//
//  Created by Dawson Foushee on 5/19/25.
//

import SwiftUI

struct StockFeaturedView: View {
    @State var stock: Stock
    
    var body: some View {
        VStack {
            Text(stock.ticker)
                .font(.headline)
            Text(stock.price, format: .number.precision(.fractionLength(2)))
                .font(.title2)
            Text(stock.priceChange24Hrs, format: .number.precision(.fractionLength(2)))
                .font(.title3)
                .foregroundStyle(stock.priceChange24Hrs > 0 ? .green : .red)
        }
    }
    
}
