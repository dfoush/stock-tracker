//
//  Stock.swift
//  Stock Tracker
//
//  Created by Dawson Foushee on 5/19/25.
//

import Foundation
import SwiftData

@Model
final class Stock: Codable, @unchecked Sendable {
    var name: String
    var ticker: String
    var price: Float
    var priceChange24Hrs: Float
    var isFeatured: Bool
    var isFavorite: Bool
    
    init(name: String, ticker: String, price: Float, priceChange24Hrs: Float, isFeatured: Bool, isFavorite: Bool = false) {
        self.name = name
        self.ticker = ticker
        self.price = price
        self.priceChange24Hrs = priceChange24Hrs
        self.isFeatured = isFeatured
        self.isFavorite = isFavorite
    }
    
    func update(from other: Stock) {
        self.name = other.name
        self.ticker = other.ticker
        self.price = other.price
        self.priceChange24Hrs = other.priceChange24Hrs
        self.isFeatured = other.isFeatured
    }
    
    enum CodingKeys: String, CodingKey {
        case name, ticker, price, isFavorite
        case priceChange24Hrs = "price_change_24hrs"
        case isFeatured = "is_featured"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.ticker = try container.decode(String.self, forKey: .ticker)
        self.price = try container.decode(Float.self, forKey: .price)
        self.priceChange24Hrs = try container.decode(Float.self, forKey: .priceChange24Hrs)
        self.isFeatured = try container.decode(Bool.self, forKey: .isFeatured)
        self.isFavorite = (try? container.decode(Bool.self, forKey: .isFavorite)) ?? false
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(ticker, forKey: .ticker)
        try container.encode(price, forKey: .price)
        try container.encode(priceChange24Hrs, forKey: .priceChange24Hrs)
        try container.encode(isFeatured, forKey: .isFeatured)
        try container.encode(isFavorite, forKey: .isFavorite)
    }
}
