//
//  DependencyInjection.swift
//  Stock Tracker
//
//  Created by Dawson Foushee on 5/20/25.
//

import Swinject

@propertyWrapper struct Injected<Dependency> {
    var wrappedValue: Dependency

    init() {
        wrappedValue = DependencyInjection.shared.container.resolve(Dependency.self)!
    }
}

final class DependencyInjection {
    
    static let shared = DependencyInjection()
    
    let container: Container = Container()
    
    func setup() {
        Task {
            container.register(StockAPI.self) { _ in LocalJSONStockAPI() }
        }
    }
}
