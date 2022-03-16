//
//  SearchLocationVM.swift
//  AlboMapLocation
//
//  Created by Hiram Castro on 13/03/22.
//

import Foundation

protocol input {
    func setKmSearchLocation(km:Int)
}

protocol output {
    func getKmSearchLocation() -> Int
}

protocol SearchLocationResponser: input, output { }

class SearchLocationVM: SearchLocationResponser {
    
    private var kmRadius:Int = 0
    
    func setKmSearchLocation(km: Int) {
        self.kmRadius = km
    }
    
    func getKmSearchLocation() -> Int {
        return self.kmRadius
    }
    
}
