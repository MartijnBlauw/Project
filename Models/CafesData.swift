//
//  CafesData.swift
//
//
//  Created by Martijn Blauw on 25-01-18.
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
