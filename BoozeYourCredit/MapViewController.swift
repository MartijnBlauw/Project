//
//  MapViewController.swift
//  BoozeYourCredit
//
//  Created by Martijn Blauw on 11-01-18.
//  Copyright © 2018 Martijn Blauw. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    var location: CLLocationCoordinate2D? = nil
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func unwindToMap(unwindSegue: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show CollectViewController when pin tapped
        mapView.delegate = self
        
        // Get the current location of the user
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        // Annotation location (test)
        let testLocationArray = PlaceLocation(title: "Groene Vlinder", name: "test", coordinate: CLLocationCoordinate2D(latitude: 52.355574, longitude: 4.893067))
        mapView.addAnnotation(testLocationArray)
        
    }
    
    // Update the current location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for currentLocation in locations {
            let coordinate = currentLocation.coordinate
            location = coordinate
        }
    }
    
    // Update location failed, give an error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    // Show CollectViewController when pin tapped
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "CollectSegue" {
//            let collectViewController = segue.destination as! CollectViewController
//        }
//    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        performSegue(withIdentifier: "CollectSegue", sender: nil)
    }
}


