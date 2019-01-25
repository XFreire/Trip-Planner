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
    private var autoCompleter: TextFieldAutoCompleter
    
    // MARK: Initialization
    init(presenter: SearchPresenterProtocol, autoCompleter: TextFieldAutoCompleter = TextFieldAutoCompleter()) {
        self.presenter = presenter
        self.autoCompleter = autoCompleter
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.didLoad()
        subscribeToTextFieldChanges()
        originField.delegate = autoCompleter
        destinationField.delegate = autoCompleter
        autoCompleter.didChangeText = { [weak self] textField in
            self?.setupBindings(with: textField)
        }
    }
    
    func setupBindings(with textField: UITextField) {
        if let text = textField.text {
            if textField == originField {
                presenter.origin = text
            } else if textField == destinationField {
                presenter.destination = text
            }
        }
    }
    
    // MARK: UITextFieldActions
    func subscribeToTextFieldChanges() {
        originField.addTarget(self, action: #selector(textDidChange(textField:)), for: .editingChanged)
        destinationField.addTarget(self, action: #selector(textDidChange(textField:)), for: .editingChanged)
    }
    
    @objc func textDidChange(textField: UITextField) {
        setupBindings(with: textField)
    }
}

extension SearchViewController: SearchView {
    func setupSuggestions(_ suggestions: [City]) {
        autoCompleter.suggestions = suggestions
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

