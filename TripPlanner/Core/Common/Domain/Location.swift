//
//  Location.swift
//  Core
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

typealias City = String

struct Location {
    
    // MARK: Properties
    let name: City
    let latitude: Double
    let longitude: Double
}
extension Location {
    var proxy: String {
        return "\(name)"
    }
}
extension Location: Hashable {
    var hashValue: Int {
        return proxy.hashValue
    }
}

extension Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.proxy == rhs.proxy
    }
}
