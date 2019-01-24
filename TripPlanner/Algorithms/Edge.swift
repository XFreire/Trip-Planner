//
//  Algorithms
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

public struct Edge<T> {
  
  public let source: Vertex<T>
  public let destination: Vertex<T>
  public let weight: Double?
}

extension Edge: Hashable where T: Hashable {}
extension Edge: Equatable where T: Equatable {}
