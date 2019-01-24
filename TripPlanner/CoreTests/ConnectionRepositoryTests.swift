//
//  ConnectionRepositoryTests.swift
//  CoreTests
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import XCTest
@testable import Core

class ConnectionRepositoryTests: XCTestCase {

    var repository: ConnectionRepositoryProtocol!
    
    override func setUp() {
        repository = MockConnectionRepository()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConnectionRepository_All_ReturnsTheCorrectList() {
        let expectation = self.expectation(description: "AllConnections")
        var connectionList: [Connection]?
        
        repository.all(then: {
            connectionList = $0
            expectation.fulfill()
        }, catchError: { _ in
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(connectionList?.count, 8)
    }
}
