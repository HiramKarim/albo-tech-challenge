//
//  ApiProtocols.swift
//  AlboMapLocation
//
//  Created by Hiram Castro on 15/03/22.
//

import Combine

protocol AirportLocationAPI: APIClient {
    func fetchAirportsLocation(km:Int, latitude:Double, longitude:Double) -> AnyPublisher<LocationModel, Error>
}
