//
//  StockTracker_PersistenceTests.swift
//  Stock TrackerTests
//
//  Created by Dawson Foushee on 5/19/25.
//

import Testing
import SwiftData
@testable import Stock_Tracker

struct StockTracker_PersistenceTests {
    
    enum TestStocks {
        static let basic = [
            Stock(name: "Test1", ticker: "TEST1", price: 101, priceChange24Hrs: 1.0, isFeatured: false),
            Stock(name: "Test2", ticker: "TEST2", price: 102, priceChange24Hrs: 2.0, isFeatured: true)
        ]
    }

    /// Test saving basic stock data, then test overwriting that data and ensure no duplicates are added
    @Test func testPersistentStore() async throws {
        await PersistentStore.shared.resetData()
        await PersistentStore.shared.saveStocks(TestStocks.basic)
        
        var fetched = await PersistentStore.shared.getAllStocks()
        #expect(fetched.count == TestStocks.basic.count)
        
        await PersistentStore.shared.saveStocks(TestStocks.basic)
        
        fetched = await PersistentStore.shared.getAllStocks()
        #expect(fetched.count == TestStocks.basic.count)
        
        await PersistentStore.shared.resetData()
        fetched = await PersistentStore.shared.getAllStocks()
        #expect(fetched.count == 0)
    }

}
