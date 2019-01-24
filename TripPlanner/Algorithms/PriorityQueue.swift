//
//  Algorithms
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

public struct PriorityQueue<Element: Equatable>: Queue {
  
  private var heap: Heap<Element>
  
  public init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) {
    heap = Heap(sort: sort, elements: elements)
  }
  
  public var isEmpty: Bool {
    return heap.isEmpty
  }
  
  public var peek: Element? {
    return heap.peek()
  }
  
  @discardableResult public mutating func enqueue(_ element: Element) -> Bool {
    heap.insert(element)
    return true
  }
  
  @discardableResult public mutating func dequeue() -> Element? {
    return heap.remove()
  }
}

