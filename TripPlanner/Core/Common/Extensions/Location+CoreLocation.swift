//
//  Location+CoreLocation.swift
//  Core
//
//  Created by Alexandre Freire on 25/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import CoreLocation

extension Location {
    var clLocationCoordinate2D: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
