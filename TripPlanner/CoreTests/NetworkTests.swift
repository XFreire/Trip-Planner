//
//  NetworkTests.swift
//  CoreTests
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import XCTest
@testable import Core

class NetworkTests: XCTestCase {
    private class Dummy {}

    var network: Network!
    
    override func setUp() {
        let path = Bundle(for: Dummy.self).path(forResource: "connection_list", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let decoder = JSONDecoder()
        let connectionList = try! decoder.decode(ConnectionListResponse.self, from: data).connections
        network = Network(connections: connectionList)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNetworkExistence() {
        XCTAssertNotNil(network)
        print(network.cities.map{ $0.name })
        print(network.cities.map{ $0.hashValue })
        XCTAssertTrue(-5543904498093997309 == -5543904498093997309)
    }
    
    func testNetworkCount() {
        XCTAssertEqual(network.count, 7)
    }
    
    func testNetwork_LocationWithNameCaseInsensitive_ReturnsTheCorrectLocationObject() {
        var location = network.location(named: "London")
        let london = Location(name: "London", latitude: 51.5285582, longitude: -0.241681)
        XCTAssertEqual(location, london)
        
        location = network.location(named: "lOnDon")
        XCTAssertEqual(location, london)
    }
    
    func testNetwork_PriceBetweenTwoCitiesAsLocation_ReturnsTheCorrectPrice() {

        // London -> Sydney
        var from = network.location(named: "London")!
        var to = network.location(named: "Sydney")!

        var price = network.price(from: from, to: to)
        XCTAssertEqual(price, 850)

        // London -> Los Angeles
        from = network.location(named: "London")!
        to = network.location(named: "Los Angeles")!

        price = network.price(from: from, to: to)
        XCTAssertEqual(price, 680)

        // New York -> Porto
        from = network.location(named: "New York")!
        to = network.location(named: "Porto")!

        price = network.price(from: from, to: to)
        XCTAssertNil(price)

        // New York -> Tokio
        from = network.location(named: "New York")!
        to = network.location(named: "Tokyo")!

        price = network.price(from: from, to: to)
        XCTAssertEqual(price, 330)
    }
    
    func testNetwork_PriceBetweenTwoCitiesAsString_ReturnsTheCorrectPrice() {
        
        // London -> Sydney
        var price = network.price(from: "London", to: "Sydney")
        XCTAssertEqual(price, 850)
        
        // London -> Los Angeles
        price = network.price(from: "London", to: "Los Angeles")
        XCTAssertEqual(price, 680)
        
        // New York -> Porto
        price = network.price(from: "New York", to: "Porto")
        XCTAssertNil(price)
        
        // New York -> Tokio
        price = network.price(from: "New York", to: "Tokyo")
        XCTAssertEqual(price, 330)
    }
    
    func testNetwork_CheapestRouteBetweenTwoCitiesAsLocation_ReturnTheCorrectConnection() {
        // London -> Sydney
        var from = network.location(named: "London")!
        var to = network.location(named: "Sydney")!
        var connections = network.cheapestConnection(from: from, to: to)
        
        XCTAssertEqual(connections.count, 2)
        XCTAssertEqual(connections[0].from.name, "London")
        XCTAssertEqual(connections[0].to.name, "Tokyo")
        XCTAssertEqual(connections[1].from.name, "Tokyo")
        XCTAssertEqual(connections[1].to.name, "Sydney")
        
        let price: Double = connections.reduce(0) { $0 + $1.price }
        XCTAssertEqual(price, 850)
        
        // Porto -> Tokyo
        from = network.location(named: "Porto")!
        to = network.location(named: "Tokyo")!
        connections = network.cheapestConnection(from: from, to: to)
        
        XCTAssertTrue(connections.isEmpty)
    }
}
