//
//  EndpointTests.swift
//  CoreTests
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import XCTest
@testable import Core

class EndpointTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEndpoint_RequestWithBaseUrl_ReturnsTheCorrectURLResponse() {
        let endpoint = Endpoint.connections
        let url = URL(string: "https://mydomain.com/api")!
        let request = endpoint.request(with: url)
        let urlResult = URL(string: "https://mydomain.com/api/connections.json?")
        XCTAssertEqual(request.url, urlResult)
        XCTAssertEqual(request.httpMethod, "GET")        
    }

}
