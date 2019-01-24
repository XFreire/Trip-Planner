//
//  Array<Connection>+price.swift
//  Core
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

extension Array where Element == Connection {
    var price: Double? {
        let price = self.reduce(0) { $0 + $1.price }
        guard price != 0 else { return nil }
        return price
    }
}
