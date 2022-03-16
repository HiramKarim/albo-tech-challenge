//
//  TabBarVM.swift
//  AlboMapLocation
//
//  Created by Hiram Castro on 16/03/22.
//

import Foundation

class TabBarVM: SearchLocationResponser {
    
    private var kmRadius:Int = 0
    
    func setKmSearchLocation(km: Int) {
        self.kmRadius = km
    }
    
    func getKmSearchLocation() -> Int {
        return self.kmRadius
    }
    
    
}
