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
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var priceTitleLabel: UILabel!
    
    // MARK: Properties
    private var presenter: SearchPresenterProtocol
    private var autoCompleter: TextFieldAutoCompleter
    private var polyline: MKPolyline?
    private var renderer: MKPolylineRenderer?
    
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
        mapView.delegate = self
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
    func setLoading(_ loading: Bool) {
        let views: [UIView?] = [originField, destinationField, priceTitleLabel, priceTitleLabel, mapView]
        views.forEach{ $0?.isHidden = loading }
        if loading {
            loadingView.startAnimating()
        } else {
            loadingView.stopAnimating()
        }
        
        
    }
    
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
        if let _ = polyline {
            renderer?.strokeColor = .clear
        }
        var locations = [CLLocationCoordinate2D]()
        route.forEach {
            locations.append($0.from.clLocationCoordinate2D)
            locations.append($0.to.clLocationCoordinate2D)
        }
        
        polyline = MKPolyline(coordinates: locations, count: locations.count)
        mapView.addOverlay(polyline!)
    }
    
    func show(error: Error) {
        #warning("TODO")
    }
}

extension SearchViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        renderer = MKPolylineRenderer(overlay: overlay)

        if overlay is MKPolyline {
            renderer!.strokeColor = .red
            renderer!.lineWidth = 3
            
            let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            mapView.setVisibleMapRect(overlay.boundingMapRect, edgePadding: padding, animated: true)
        }
        
        return renderer!
    }
    
    func mapView(_ mapView: MKMapView, didAdd renderers: [MKOverlayRenderer]) {
        print("Renderer added")
    }
}
