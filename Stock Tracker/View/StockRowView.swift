//
//  StockRowView.swift
//  Stock Tracker
//
//  Created by Dawson Foushee on 5/19/25.
//

import SwiftUI

struct StockRowView: View {
    @State var stock: Stock
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(stock.ticker)
                    .font(.title2)
                Text(stock.name)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(stock.price, format: .number.precision(.fractionLength(2)))
                    .font(.title3)
                Text(stock.priceChange24Hrs, format: .number.precision(.fractionLength(2)))
                    .foregroundStyle(stock.priceChange24Hrs > 0 ? .green : .red)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Button {
                stock.isFavorite = !stock.isFavorite
            } label: {
                Image(systemName: stock.isFavorite ? "heart.fill" : "heart")
            }
            .padding(.leading, 16)
        }
    }
    
}
