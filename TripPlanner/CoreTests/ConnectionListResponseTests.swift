//
//  ConnectionListResponseTests.swift
//  CoreTests
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import XCTest
@testable import Core
class ConnectionListResponseTests: XCTestCase {

    private class Dummy {}
    
    var connectionListResponse: ConnectionListResponse!
    
    override func setUp() {
        let path = Bundle(for: Dummy.self).path(forResource: "connection_list", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let decoder = JSONDecoder()
        connectionListResponse = try! decoder.decode(ConnectionListResponse.self, from: data)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConnectionListResponseExistence() {
        XCTAssertNotNil(connectionListResponse)
    }
    
    func testConnectionListResponse_connectionsCount_ReturnsTheCorrectValue() {
        XCTAssertEqual(connectionListResponse.connections.count, 8)
    }
}
