//
//  ConnectionRepository.swift
//  Core
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

protocol ConnectionRepositoryProtocol {
    func all(then completion: @escaping ([Connection]) -> Void, catchError: @escaping (Error) -> Void)
    func cheapestConnection(between fromCity: City, and toCity: City, then completion: @escaping (Connection?) -> Void, catchError: @escaping (Error) -> Void)
}

final class ConnectionRepository: ConnectionRepositoryProtocol {

    // MARK: Properties
    private let webService: WebService
    
    // MARK: Initialization
    init(webService: WebService) {
        self.webService = webService
    }
    
    // MARK: ConnectionRepositoryProtocol
    func all(then completion: @escaping ([Connection]) -> Void, catchError: @escaping (Error) -> Void) {
        
        webService.load(ConnectionListResponse.self, from: .connections, then: {
            completion($0.connections)
        }, catchError: {
            catchError($0)
        })
    }
}

extension ConnectionRepositoryProtocol {
    func cheapestConnection(between fromCity: City, and toCity: City, then completion: @escaping (Connection?) -> Void, catchError: @escaping (Error) -> Void) {
        
        #warning("Implement this")
    }
}
