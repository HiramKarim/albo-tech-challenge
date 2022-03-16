//
//  MapVC.swift
//  AlboMapLocation
//
//  Created by Hiram Castro on 14/03/22.
//

import UIKit
import MapKit

final class MapVC: UIViewController {
    
    private let locationManager = CLLocationManager()
    private let rangeInMeters: Double = 60000
    
    private var viewModel:MapViewModelResponser?
    
    private let mapView: MKMapView = {
        let map = MKMapView(frame: .zero)
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        checkLocationServices()
    }
    
    private func configView() {
        self.view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
    }
    
    convenience init(viewModel:MapViewModelResponser) {
        self.init()
        self.viewModel = viewModel
        self.viewModel?.loadAirportsOnMapCallback = loadAirportsCallback
    }
    
    func loadAirportsCallback(airportLocations:[LocationCoordinate]) {
        mapView.addAnnotations(airportLocations)
    }
    
}

private extension MapVC {
    private func checkLocationServices() {
        guard CLLocationManager.locationServicesEnabled() else {
            return
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        checkAuthorizationForLocation()
    }
    
    private func checkAuthorizationForLocation() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            mapView.showsUserLocation = true
            centerViewOnUser()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Here we must tell user how to turn on location on device
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
                // Here we must tell user that the app is not authorize to use location services
            break
        @unknown default:
            break
        }
    }
    
    private func centerViewOnUser() {
        guard let location = locationManager.location?.coordinate else { return }
        
        self.viewModel?.setLatitude(latitude: location.latitude)
        self.viewModel?.setLongitude(longitude: location.longitude)
        
        let coordinateRegion = MKCoordinateRegion.init(center: location,
                                                       latitudinalMeters: rangeInMeters,
                                                       longitudinalMeters: rangeInMeters)
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: coordinateRegion), animated: true)
        //mapView.setRegion(coordinateRegion, animated: true)
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
        self.viewModel?.loadAirports()
    }
}

extension MapVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthorizationForLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate,
                                                       latitudinalMeters: rangeInMeters,
                                                       longitudinalMeters: rangeInMeters)
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: coordinateRegion), animated: true)
        //mapView.setRegion(coordinateRegion, animated: true)
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
        mapView.isScrollEnabled = true
        mapView.setCameraZoomRange(zoomRange, animated: true)
    }
}
