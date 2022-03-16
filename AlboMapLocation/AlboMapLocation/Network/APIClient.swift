//
//  APIClient.swift
//  AlboMapLocation
//
//  Created by Hiram Castro on 14/03/22.
//

import Foundation
import Combine

protocol APIClient {
    func fetchAirportsLocation<T>(km:Int, latitude:Double, longitude:Double, endpoint: EndPoint, type: T.Type) -> AnyPublisher<T, Error> where T:Decodable
}

extension APIClient {
    func fetchAirportsLocation<T>(km:Int, latitude:Double, longitude:Double, endpoint: EndPoint, type: T.Type) -> AnyPublisher<T, Error> where T: Decodable {
        let newPath = (
            endpoint.path.replacingOccurrences(of: "<lat>", with: String(latitude))
                        .replacingOccurrences(of: "<long>", with: String(longitude))
                        .replacingOccurrences(of: "<km>", with: String(km))
        )
        
        let newURL = "\(endpoint.baseURL)\(newPath)"
        var urlRequest = URLRequest(url: URL(string: newURL)!)
        urlRequest.httpMethod = endpoint.method.rawValue
        
        let headers = [
            "X-RapidAPI-Host": "aerodatabox.p.rapidapi.com",
            "X-RapidAPI-Key": "f8bb5a0214msh006212a656a2a46p1be610jsn0c00cff063e9"
        ]

        urlRequest.allHTTPHeaderFields = headers
        
        
//        endpoint.headers?.forEach {
//            urlRequest.setValue($0.key, forHTTPHeaderField: $0.value)
//        }
        
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
