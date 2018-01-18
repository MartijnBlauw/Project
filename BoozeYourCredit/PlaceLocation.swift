//
//  PlaceLocation.swift
//  BoozeYourCredit
//
//  Created by Martijn Blauw on 18-01-18.
//  Copyright © 2018 Martijn Blauw. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class PlaceLocation: NSObject, MKAnnotation {
    let title: String?
    let name: String
    let coordinate: CLLocationCoordinate2D

    init(title: String?, name: String, coordinate: CLLocationCoordinate2D){
        self.title = title
        self.name = name
        self.coordinate = coordinate
        
        super.init()
    }
}
