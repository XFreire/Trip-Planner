//
//  AlgorithmsTests.swift
//  AlgorithmsTests
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import XCTest
@testable import Algorithms

class AlgorithmsTests: XCTestCase {
    var london: Vertex<String>!
    var tokio: Vertex<String>!
    var sydney: Vertex<String>!
    var capeTown: Vertex<String>!
    var newYork: Vertex<String>!
    var porto: Vertex<String>!
    var losAngeles: Vertex<String>!
    
    var graph: AdjacencyList<String>!

    override func setUp() {
        // Graph
        graph = AdjacencyList<String>()

        // Vertex
        london = graph.createVertex(data: "London")
        tokio = graph.createVertex(data: "Tokio")
        sydney = graph.createVertex(data: "Sydney")
        capeTown = graph.createVertex(data: "Cape Town")
        newYork = graph.createVertex(data: "New York")
        porto = graph.createVertex(data: "Porto")
        losAngeles = graph.createVertex(data: "Los Angeles")
        
        // Edges
        graph.add(.directed, from: london, to: tokio, weight: 600)
        graph.add(.directed, from: london, to: porto, weight: 50)
        graph.add(.directed, from: london, to: newYork, weight: 500)
        graph.add(.directed, from: london, to: capeTown, weight: 700)
        graph.add(.directed, from: tokio, to: sydney, weight: 250)
        graph.add(.directed, from: sydney, to: capeTown, weight: 300)
        graph.add(.directed, from: newYork, to: losAngeles, weight: 180)
        graph.add(.directed, from: losAngeles, to: tokio, weight: 150)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAdjacencyList_Count() {
        XCTAssertEqual(graph.vertices.count, 7)
    }
    
    
    func testDijkstra_findShortestPathBetweenTwoVertex_ReturnsTheCorrectPath() {
        let dijkstra = Dijkstra(graph: graph)
        let pathsFromLondon = dijkstra.shortestPath(from: london)
        
        let path = dijkstra.shortestPath(to: sydney, paths: pathsFromLondon)
        XCTAssertEqual(path.count, 2)
    }
    
    func testVertex_Equality() {
        let vertex = Vertex(data: "London")
        
        XCTAssertEqual(london, vertex)
    }
    
    func testDijkstra_VertexWithData_ReturnsTheCorrectVertex() {
        let vertex = Vertex(data: "London")
        XCTAssertEqual(graph.vertex(with: "London"), vertex)
    }
}
