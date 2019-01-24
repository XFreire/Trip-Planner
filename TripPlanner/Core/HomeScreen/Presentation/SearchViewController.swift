//
//  SearchViewController.swift
//  Core
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import UIKit
import MapKit

class SearchViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var originField: UITextField!
    @IBOutlet weak var destinationField: UITextField!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: Properties
    private var presenter: SearchPresenterProtocol
    
    // MARK: Initialization
    init(presenter: SearchPresenterProtocol) {
        self.presenter = presenter
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.didLoad()
    }
}

extension SearchViewController: SearchView {
    func showSourceSuggestions(_ suggestions: [City]) {
        #warning("TODO")
    }
    
    func showDestinationSuggestions(_ suggestions: [City]) {
        #warning("TODO")
    }
    
    func show(price: Double?) {
        if let price = price {
            priceLabel.text = "£ \(price)"
        } else {
            priceLabel.text = " - "
        }
        
    }
    
    func show(route: [Connection]) {
        #warning("TODO")
    }
    
    func show(error: Error) {
        #warning("TODO")
    }
    
    
}
