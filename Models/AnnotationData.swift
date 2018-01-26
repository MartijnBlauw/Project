//
//  AnnotationData.swift
//  BoozeYourCredit
//
//  Created by Martijn Blauw on 25-01-18.
//  Copyright © 2018 Martijn Blauw. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class CafesLocation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D){
        self.title = title
        self.coordinate = coordinate
        
        super.init()
    }
}
