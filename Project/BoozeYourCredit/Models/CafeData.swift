//
//  CafeData.swift
//  BoozeYourCredit
//
//  Load data from the API
//
//  Created by Martijn Blauw on 31-01-18.
//  Copyright © 2018 Martijn Blauw. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

struct PlaceLocation: Codable {
    var name: String
    var geolocation: [String: Double]
    
    var title: String? {
        get {
            return name
        }
    }
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: geolocation["latitude"]!, longitude: geolocation["longitude"]!)
        }
    }
}

struct PlaceLocations: Codable {
    let results: [PlaceLocation]
}
