//
//  ConnectionRepository.swift
//  Core
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

protocol NetworkRepositoryProtocol {
    func network(then completion: @escaping (Network) -> Void, catchError: @escaping (Error) -> Void)
}

final class ConnectionRepository: NetworkRepositoryProtocol {

    // MARK: Properties
    private let webService: WebService
    
    // MARK: Initialization
    init(webService: WebService) {
        self.webService = webService
    }
    
    // MARK: ConnectionRepositoryProtocol
    func network(then completion: @escaping (Network) -> Void, catchError: @escaping (Error) -> Void) {
        
        webService.load(ConnectionListResponse.self, from: .connections, then: {
            completion(Network(connections: $0.connections))
        }, catchError: {
            catchError($0)
        })
    }
}
