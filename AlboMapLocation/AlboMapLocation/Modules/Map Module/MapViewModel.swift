//
//  MapViewModel.swift
//  AlboMapLocation
//
//  Created by Hiram Castro on 15/03/22.
//

import Foundation
import Combine
import MapKit

protocol MapViewModelInput {
    func setKmInRange(km:Int)
    func setLatitude(latitude:Double)
    func setLongitude(longitude:Double)
}

protocol MapViewModelOutput {
    var showErrorCallback:((_ error: Error)->Void)? { get set }
    var loadAirportsOnMapCallback:((_ airportLocations:[LocationCoordinate])->Void)? { get set }
    func loadAirports()
    func getKmRadius() -> Int
    func getAirportsLocations() -> [LocationData]
}

protocol MapViewModelResponser: MapViewModelInput, MapViewModelOutput { }

class MapViewModel: MapViewModelResponser {
    
    private var airportLocations:[LocationData]?
    private var kmInRange:Int = 0
    private var locationLatitude:Double = 0
    private var locationLongitude:Double = 0
    
    private let apiService: AirportLocationAPI
    private var subscriptions = Set<AnyCancellable>()
    
    var showErrorCallback:((_ error: Error)->Void)?
    var loadAirportsOnMapCallback:((_ airportLocations:[LocationCoordinate])->Void)?
    
    init(apiService: AirportLocationAPI = AirportLocationApiService()) {
        self.apiService = apiService
    }
    
    func setKmInRange(km: Int) {
        self.kmInRange = km
    }
    
    func setLatitude(latitude: Double) {
        self.locationLatitude = latitude
    }
    
    func setLongitude(longitude: Double) {
        self.locationLongitude = longitude
    }
    
    func getKmRadius() -> Int {
        return self.kmInRange
    }
    
    func getAirportsLocations() -> [LocationData] {
        return airportLocations ?? []
    }
    
    private func createMapAnnotations() {
        var mapAnnotations = [LocationCoordinate]()
        
        guard let locationData = airportLocations else { return }
        
        for data in locationData {
            mapAnnotations.append(LocationCoordinate(title: data.name ?? "",
                                                     coordinate:CLLocationCoordinate2D(latitude: data.location?.latitude ?? 0,
                                                                                       longitude: data.location?.longitude ?? 0)))
        }
        
        loadAirportsOnMapCallback?(mapAnnotations)
    }
    
    func loadAirports() {
        
        apiService.fetchAirportsLocation(km: kmInRange, latitude: locationLatitude, longitude: locationLongitude)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case let .failure(error):
                    self.showErrorCallback?(error)
                case .finished: break
                }
            } receiveValue: { [weak self] result in
                guard let self = self else { return }
                Helper.shared.airportsLocations = result.items
                self.airportLocations = result.items
                self.createMapAnnotations()
            }
            .store(in: &subscriptions)
        
        
    }
}
