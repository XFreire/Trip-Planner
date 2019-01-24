//
//  Network.swift
//  Core
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation
import Algorithms

final class Network {
    
    // MARK: Properties
    private let graph: AdjacencyList<Location>
    
    // MARK: Initialization
    init(connections: [Connection]) {
        graph = AdjacencyList<Location>()
        
        // Add Vertex to graph
        connections.forEach { [weak self] in
            guard let self = self else { return }
            
            self.graph.createVertex(data: $0.from)
            self.graph.createVertex(data: $0.to)
        }
        
        // Add edges
        connections.forEach { [weak self] connection in
            guard let self = self else { return }
            
            guard let from = graph.vertex(with: connection.from),
                let to = graph.vertex(with: connection.to) else { return }
            
            self.graph.add(.directed, from: from, to: to, weight: connection.price)
        }
    }
}

extension Network {
    var count: Int {
        return graph.vertices.count
    }
    
    var cities: [Location] {
        return graph.vertices.map { $0.data }
    }
    
    func location(named name: String) -> Location? {
        return graph.location(named: name)
    }
}

extension Network {
    private var dijkstra: Dijkstra<Location> {
        return Dijkstra(graph: graph)
    }
}

extension Network {
    func price(from cityFrom: Location, to cityTo: Location) -> Double? {
        let connections = cheapestConnection(from: cityFrom, to: cityTo)
        
        guard !connections.isEmpty else {
            return nil
        }
        
        return connections.price
    }
    
    func price(from cityFrom: String, to cityTo: String) -> Double? {
        guard let from = location(named: cityFrom),
            let to = location(named: cityTo) else {
                return nil
        }
        
        return price(from: from, to: to)
    }
}

extension Network {
    
    func cheapestConnection(from cityFrom: Location, to cityTo: Location) -> [Connection] {
        guard let from = graph.vertex(with: cityFrom),
            let to = graph.vertex(with: cityTo) else { return [] }
        
        let pathsFromCityFrom = dijkstra.shortestPath(from: from)
        let path = dijkstra.shortestPath(to: to, paths: pathsFromCityFrom)
    
        return path.map { $0.connection }
    }
    
    func cheapestConnection(from cityFrom: String, to cityTo: String) -> [Connection] {
        guard let from = graph.vertex(named: cityFrom),
            let to = graph.vertex(named: cityTo) else {
                return []
        }
        
        let pathsFromCityFrom = dijkstra.shortestPath(from: from)
        let path = dijkstra.shortestPath(to: to, paths: pathsFromCityFrom)
        
        return path.map { $0.connection }
    }
}


