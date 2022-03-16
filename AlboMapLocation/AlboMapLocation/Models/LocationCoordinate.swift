//
//  LocationCoordinate.swift
//  AlboMapLocation
//
//  Created by Hiram Castro on 15/03/22.
//

import MapKit

class LocationCoordinate: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(
        title: String?,
        coordinate: CLLocationCoordinate2D
      ) {
        self.title = title
        self.coordinate = coordinate

        super.init()
      }
}
