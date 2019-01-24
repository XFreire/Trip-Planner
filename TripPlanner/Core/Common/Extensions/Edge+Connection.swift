//
//  Edge+Connection.swift
//  Core
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation
import Algorithms

extension Edge where T == Location {
    var connection: Connection {
        let from = source.data
        let to = destination.data
        let price = weight ?? 0.0
        return Connection(from: from, to: to, price: price)
    }
}
