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
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToTextFieldChanges()
        presenter.view = self
        presenter.didLoad()
    }
    
    // MARK: UITextFieldActions
    func subscribeToTextFieldChanges() {
        originField.addTarget(self, action: #selector(textDidChange(textField:)), for: .editingChanged)
        destinationField.addTarget(self, action: #selector(textDidChange(textField:)), for: .editingChanged)
    }
    
    @objc func textDidChange(textField: UITextField) {
        guard let text = textField.text, text.count > 2 else { return }
        if textField == originField {
            presenter.source = text
        } else if textField == destinationField {
            presenter.destination = text
        }
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
