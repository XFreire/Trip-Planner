//
//  MockConnectionRepository.swift
//  CoreTests
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation
@testable import Core

final class MockConnectionRepository: ConnectionRepositoryProtocol {
    func all(then completion: @escaping ([Connection]) -> Void, catchError: @escaping (Error) -> Void) {
        let path = Bundle(for: MockConnectionRepository.self).path(forResource: "connection_list", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let decoder = JSONDecoder()
        let connectionListResponse = try! decoder.decode(ConnectionListResponse.self, from: data)
        
        completion(connectionListResponse.connections)
    }
}
