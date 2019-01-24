//
//  AdjacencyList+Location.swift
//  Core
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation
@testable import Algorithms

extension AdjacencyList where T == Location {
    
    func location(named name: String) -> Location? {
        let vertex = vertices.first{ $0.data.name.lowercased() == name.lowercased() }
        return vertex?.data
    }
    
    func vertex(named name: String) -> Vertex<Location>? {
        guard let location = self.location(named: name) else { return nil }
        return vertex(with: location)
    }
}
