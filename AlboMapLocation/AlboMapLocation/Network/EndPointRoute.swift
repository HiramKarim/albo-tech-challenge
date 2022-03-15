//
//  EndPointRoute.swift
//  AlboMapLocation
//
//  Created by Hiram Castro on 14/03/22.
//

import Foundation

enum QuestionsEndpoint {
    case fetchAirportLocations
}

extension QuestionsEndpoint: EndPoint {
    var baseURL: URL {
        guard let url = URL(string: Constants.baseUrl) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .fetchAirportLocations:
            return Constants.airportLocationAPIURL
        }
    }
    
    var method: HTTPRequestMethod {
        switch self {
        case .fetchAirportLocations:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .fetchAirportLocations:
            return[
                "x-rapidapi-host": "aerodatabox.p.rapidapi.com",
                "x-rapidapi-key": "f8bb5a0214msh006212a656a2a46p1be610jsn0c00cff063e9"
            ]
        }
    }
    
}
