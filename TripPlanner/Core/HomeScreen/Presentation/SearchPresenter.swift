//
//  SearchPresenter.swift
//  Core
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

protocol SearchView: class {
    func showSourceSuggestions(_ suggestions: [City])
    func showDestinationSuggestions(_ suggestions: [City])
    func show(price: Double?)
    func show(route: [Connection])
    func show(error: Error)
}

protocol SearchPresenterProtocol {
    var view: SearchView? { get set }
    var source: String { get set }
    var destination: String { get set }
    var network: Network? { get set }
    func didLoad()
}

final class SearchPresenter: SearchPresenterProtocol {
    
    // MARK: Properties
    private let repository: NetworkRepositoryProtocol
    
    weak var view: SearchView?
    
    var source: String = "" {
        didSet {
            updateConnections()
        }
    }
    
    var destination: String = "" {
        didSet {
            updateConnections()
        }
    }
    
    var network: Network?
    
    // MARK: Initialization
    init(repository: NetworkRepositoryProtocol) {
        self.repository = repository
    }
    
    func didLoad() {
        repository.network(then: { [weak self] in
            guard let self = self else { return }
            self.network = $0
            self.updateConnections()
        }, catchError: { [weak self] in
            self?.view?.show(error: $0)
        })
    }
    
    private func updateConnections() {
        guard let connections = network?.cheapestConnection(from: source, to: destination) else {
            return
        }
        view?.show(price: connections.price)
    }
}
