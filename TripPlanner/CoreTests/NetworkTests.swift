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
    }
    
    func testNetworkCount() {
        XCTAssertEqual(network.count, 7)
    }
    
    func testNetworkCities() {
        XCTAssertEqual(network.cities.count, 7)
    }
    
    func testNetwork_LocationWithNameCaseInsensitive_ReturnsTheCorrectLocationObject() {
        var location = network.location(named: "London")
        let london = Location(name: "London", latitude: 51.5285582, longitude: -0.241681)
        XCTAssertEqual(location, london)
        
        location = network.location(named: "lOnDon")
        XCTAssertEqual(location, london)
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
    
    func testNetwork_CheapestRouteBetweenTwoCitiesAsStrings_ReturnTheCorrectConnection() {
        // London -> Sydney
        var connections = network.cheapestConnection(from: "London", to: "Sydney")
        
        XCTAssertEqual(connections.count, 2)
        XCTAssertEqual(connections[0].from.name, "London")
        XCTAssertEqual(connections[0].to.name, "Tokyo")
        XCTAssertEqual(connections[1].from.name, "Tokyo")
        XCTAssertEqual(connections[1].to.name, "Sydney")
        
        // Porto -> Tokyo
        connections = network.cheapestConnection(from: "Porto", to: "Tokyo")
        XCTAssertTrue(connections.isEmpty)
        
        // London -> London
        connections = network.cheapestConnection(from: "LoNdon", to: "London")
        XCTAssertTrue(connections.isEmpty)
    }
}
