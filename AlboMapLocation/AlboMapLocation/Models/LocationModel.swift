//
//  LocationModel.swift
//  AlboMapLocation
//
//  Created by Hiram Castro on 14/03/22.
//

import Foundation
import MapKit

struct LocationModel: Decodable {
    let items:[LocationData]
}

struct LocationData:Decodable {
    let icao:String?
    let iata:String?
    let name:String?
    let shortName:String?
    let municipalityName:String?
    let location:LocationCoordinatesData?
    let countryCode:String?
}

struct LocationCoordinatesData:Decodable {
    let latitude:Double?
    let longitude:Double?
    
    private enum CodingKeys : String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}
