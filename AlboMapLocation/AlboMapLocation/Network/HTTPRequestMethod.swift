//
//  HTTPRequestMethod.swift
//  AlboMapLocation
//
//  Created by Hiram Castro on 14/03/22.
//

import Foundation

enum HTTPRequestMethod: String {
    case get = "GET"
}

protocol EndPoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPRequestMethod { get }
    var headers: [String:String]? { get }
}
