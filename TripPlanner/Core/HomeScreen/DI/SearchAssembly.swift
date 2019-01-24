//
//  SearchAssembly.swift
//  Core
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

final public class SearchAssembly {
    
    // MARK: Properties
    private let webServiceAssembly: WebServiceAssembly
    
    // MARK: Initialization
    init(webServiceAssembly: WebServiceAssembly) {
        self.webServiceAssembly = webServiceAssembly
    }
    
    func viewController() -> UIViewController {
        return SearchViewController(presenter: presenter())
    }
    
    func presenter() -> SearchPresenterProtocol {
        return SearchPresenter(repository: repository())
    }
    
    func repository() -> NetworkRepositoryProtocol {
        return NetworkRepository(webService: webServiceAssembly.webService)
    }
}
