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

    var repository: NetworkRepositoryProtocol!
    
    override func setUp() {
        repository = MockNetworkRepository()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConnectionRepository_All_ReturnsTheCorrectList() {
        let expectation = self.expectation(description: "AllConnections")
        var network: Network?
        
        repository.network(then: {
            network = $0
            expectation.fulfill()
        }, catchError: { _ in
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(network?.count, 7)
    }
}
