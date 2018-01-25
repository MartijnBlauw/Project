//
//  RegionData.swift
//  BoozeYourCredit
//
//  Created by Martijn Blauw on 25-01-18.
//  Copyright © 2018 Martijn Blauw. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

struct RegionName {
    let title: String?
    
    init(title: String){
        self.title = title
    }
}

class RegionCoordinate: NSObject {
    let coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D){
        self.coordinate = coordinate
        
        super.init()
    }
}

