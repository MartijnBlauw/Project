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

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: Properties
    var cafes: [PlaceLocation]?
    var locationManager : CLLocationManager = CLLocationManager()
    var location: CLLocationCoordinate2D? = nil

    
    // MARK: Actions
    @IBAction func unwindToMap(unwindSegue: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Show CollectViewController when pin tapped
        self.mapView.delegate = self
        
        // Get the current location of the user
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        
        // Load the markers on the map
        if let cafes = cafes {
            for cafe in cafes {
                let cafeAnnotation = CafesLocation(title: cafe.title!, coordinate: cafe.coordinate)
                mapView.addAnnotation(cafeAnnotation)
            }
        }
    }

    // Declare region
    func setUpGeofenceForCafes() {
        if let cafes = cafes {
            for cafe in cafes {
                let geofenceRegionCenter = RegionCoordinate(coordinate: cafe.coordinate)
                let geofenceRegion = CLCircularRegion(center: geofenceRegionCenter.coordinate, radius: 1000, identifier: String(describing: RegionName(title: cafe.title!)))
                geofenceRegion.notifyOnExit = true
                geofenceRegion.notifyOnEntry = true
                let regionCircle = MKCircle(center: geofenceRegionCenter.coordinate, radius: 1000)
                self.mapView.add(regionCircle)
                self.locationManager.startMonitoring(for: geofenceRegion)
            }
        }
        
        self.mapView.showsUserLocation = true
    }
    
    // Draw circle of the region
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let overlayRenderer : MKCircleRenderer = MKCircleRenderer(overlay: overlay);
        overlayRenderer.lineWidth = 3.0
        overlayRenderer.strokeColor = UIColor(red: 0.52, green: 0.18, blue: 0.87, alpha: 1.0)
        overlayRenderer.fillColor = UIColor(red: 0.52, green: 0.18, blue: 0.87, alpha: 0.7)
        
        return overlayRenderer
    }
    
    // Set up geofence
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.authorizedAlways) {
            self.setUpGeofenceForCafes()
        }
    }
    
    // Start monitoring
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("Start monitoring")
    }
    
    // Enter the region
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Did enter")
    }
    
    // Exit the region
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Did exit")
    }
    
    // Check if the user is still in the region
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        if state == CLRegionState.inside {
            print("Still in the region")
        }
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
    
    // When pin tapped, go to next screen
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        performSegue(withIdentifier: "CollectSegue", sender: nil)
    }
}



