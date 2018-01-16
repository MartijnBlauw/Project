//
//  MapViewController.swift
//  BoozeYourCredit
//
//  Created by Martijn Blauw on 11-01-18.
//  Copyright © 2018 Martijn Blauw. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Setup mapview
        let camera = GMSCameraPosition.camera(withLatitude: 52.355515, longitude: 4.893410, zoom: 15.0)
        self.mapView.camera = camera
        
    }
}
