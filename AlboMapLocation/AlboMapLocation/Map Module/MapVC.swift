//
//  MapVC.swift
//  AlboMapLocation
//
//  Created by Hiram Castro on 14/03/22.
//

import UIKit
import MapKit

final class MapVC: UIViewController {
    
    private let mapView: MKMapView = {
        let map = MKMapView(frame: .zero)
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
    }
    
    private func configView() {
        self.view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
    }
    
}
