//
//  Connection.swift
//  Core
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

struct Connection: Decodable {
    
    // MARK: Properties
    let from: Location
    let to: Location
    let price: Double
    
    // MARK: Initialization
    init(from: Location, to: Location, price: Double) {
        (self.from, self.to, self.price) = (from, to, price)
    }
    
    // MARK: - Decodable
    private enum ContainerCodingKeys: String, CodingKey {
        case from, to, price, coordinates
    }
    
    private enum CoordinatesContainerCodingKeys: String, CodingKey {
        case from, to
    }
    
    private enum CoordinatesCodingKeys: String, CodingKey {
        case lat, long
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ContainerCodingKeys.self)
        let coordinatesContainer = try container.nestedContainer(keyedBy: CoordinatesContainerCodingKeys.self, forKey: .coordinates)
        let fromCoordinatesContainer = try coordinatesContainer.nestedContainer(keyedBy: CoordinatesCodingKeys.self, forKey: .from)
        let toCoordinatesContainer = try coordinatesContainer.nestedContainer(keyedBy: CoordinatesCodingKeys.self, forKey: .to)
        
        // From Location
        let fromName = try container.decode(String.self, forKey: .from)
        let fromLat = try fromCoordinatesContainer.decode(Double.self, forKey: .lat)
        let fromLong = try fromCoordinatesContainer.decode(Double.self, forKey: .long)
        
        self.from = Location(name: fromName, latitude: fromLat, longitude: fromLong)
        
        // To Location
        let toName = try container.decode(String.self, forKey: .to)
        let toLat = try toCoordinatesContainer.decode(Double.self, forKey: .lat)
        let toLong = try toCoordinatesContainer.decode(Double.self, forKey: .long)
        
        self.to = Location(name: toName, latitude: toLat, longitude: toLong)
        
        // Price
        self.price = try container.decode(Double.self, forKey: .price)
    }
}

extension Connection: Hashable, Equatable {} 
