//
//  CoreAssembly.swift
//  Core
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

final public class CoreAssembly {
    
    // MARK: Properties
    public private(set) lazy var searchAssembly = SearchAssembly(webServiceAssembly: webServiceAssembly)

    private(set) lazy var webServiceAssembly = WebServiceAssembly()
    
    private let navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
