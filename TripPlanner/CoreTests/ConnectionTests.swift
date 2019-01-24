//
//  ConnectionTests.swift
//  CoreTests
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import XCTest
@testable import Core
class ConnectionTests: XCTestCase {

    private class Dummy {}
    
    var connection: Connection!
    
    override func setUp() {
        let path = Bundle(for: Dummy.self).path(forResource: "connection", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let decoder = JSONDecoder()
        connection = try! decoder.decode(Connection.self, from: data)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConnectionExistence() {
        XCTAssertNotNil(connection)
    }
    
    func testConnectionHashable() {
        XCTAssertNotNil(connection.hashValue)
    }
    
    func testConnectionEquality() {
        XCTAssertEqual(connection, connection)
        
        let otherConnection = Connection(from: Location(name: "London", latitude: 0, longitude: 0), to: Location(name: "Los Angeles", latitude: 0, longitude: 0), price: 300)
        
        XCTAssertNotEqual(connection, otherConnection)
    }
}
