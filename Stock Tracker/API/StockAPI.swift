//
//  StockAPI.swift
//  Stock Tracker
//
//  Created by Dawson Foushee on 5/19/25.
//

import Foundation

protocol StockAPI {
    nonisolated init()
    func fetchStockData() async
}
