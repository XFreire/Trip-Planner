//
//  MockConnectionRepository.swift
//  CoreTests
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation
@testable import Core

final class MockNetworkRepository: NetworkRepositoryProtocol {
    func network(then completion: @escaping (Network) -> Void, catchError: @escaping (Error) -> Void) {
        let path = Bundle(for: MockNetworkRepository.self).path(forResource: "connection_list", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let decoder = JSONDecoder()
        let connectionListResponse = try! decoder.decode(ConnectionListResponse.self, from: data)
        
        completion(Network(connections: connectionListResponse.connections))
    }
}
