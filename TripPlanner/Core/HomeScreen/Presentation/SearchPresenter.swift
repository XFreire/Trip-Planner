//
//  SearchPresenter.swift
//  Core
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

protocol SearchView: class {
    func setLoading(_ loading: Bool)
    func setupSuggestions(_ suggestions: [City])
    func show(price: Double?)
    func show(route: [Connection])
    func show(error: Error)
}

protocol SearchPresenterProtocol {
    var view: SearchView? { get set }
    var origin: String { get set }
    var destination: String { get set }
    var network: Network? { get set }
    func didLoad()
}

final class SearchPresenter: SearchPresenterProtocol {
    
    // MARK: Properties
    private let repository: NetworkRepositoryProtocol
    
    weak var view: SearchView?
    
    var origin: String = "" {
        didSet {
            updateConnections()
        }
    }
    
    var destination: String = "" {
        didSet {
            updateConnections()
        }
    }
    
    var cities: [City] {
        return network?.cities ?? []
    }
    
    var network: Network?
    
    
    
    // MARK: Initialization
    init(repository: NetworkRepositoryProtocol) {
        self.repository = repository
    }
    
    func didLoad() {
        view?.setLoading(true)
        repository.network(then: { [weak self] in
            guard let self = self else { return }
            self.network = $0
            self.updateConnections()
            self.view?.setLoading(false)
        }, catchError: { [weak self] in
            self?.view?.show(error: $0)
        })
    }
    
    private func updateConnections() {
        print("Origin: \(origin)")
        print("Dest: \(destination)")
    
        guard origin.count > 0 && destination.count > 0 else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let network = self.network else { return }
            self.view?.setupSuggestions(network.cities)
            let connections = network.cheapestConnection(from: self.origin, to: self.destination)
            guard !connections.isEmpty else {
                self.view?.show(route: [])
                self.view?.show(price: nil)
                return
            }
            self.view?.show(route: connections)
            self.view?.show(price: connections.price)
            
        }

        
    }
}
