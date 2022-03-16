//
//  APIService.swift
//  AlboMapLocation
//
//  Created by Hiram Castro on 15/03/22.
//

import Combine

struct AirportLocationApiService: AirportLocationAPI {
    func fetchAirportsLocation(km: Int, latitude: Double, longitude: Double) -> AnyPublisher<LocationModel, Error> {
        return fetchAirportsLocation(km: km, latitude: latitude, longitude: longitude, endpoint: QuestionsEndpoint.fetchAirportLocations, type: LocationModel.self)
    }
}
