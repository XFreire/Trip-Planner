//
//  LocationTests.swift
//  CoreTests
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import XCTest
@testable import Core
import CoreLocation

class LocationTests: XCTestCase {
    
    var london: Location!
    
    override func setUp() {
        london = Location(name: "London", latitude: 51.5285582, longitude: -0.241681)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLocationExistence() {
        XCTAssertNotNil(london)
    }
    
    func testLocationHashable() {
        XCTAssertNotNil(london.hashValue)
    }
    
    func testLocationEquality() {
        // Identity
        XCTAssertEqual(london, london)
        
        // Equality
        let otherLondon = Location(name: "London", latitude: 51.5285582, longitude: -0.241681)
        XCTAssertEqual(london, otherLondon)
        
        // Inequality
        let casterlyRock = Location(name: "Casterly Rock", latitude: 51.5285582, longitude: -0.241681)
        XCTAssertNotEqual(london, casterlyRock)
    }
    
    func testLocationCoordinate2D() {
        let londonLocationCoordinate2D = london.clLocationCoordinate2D
        let coordinate = CLLocationCoordinate2D(latitude: london.latitude, longitude: london.longitude)
        
        XCTAssertEqual(londonLocationCoordinate2D.latitude, coordinate.latitude)
        XCTAssertEqual(londonLocationCoordinate2D.longitude, coordinate.longitude)
    }
}
