//
//  ConnectionResponse.swift
//  Core
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

struct ConnectionListResponse: Decodable {
    
    // MARK: Properties
    let connections: [Connection]
}
