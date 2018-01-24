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
    var locationManager : CLLocationManager = CLLocationManager()
    var location: CLLocationCoordinate2D? = nil
    var cafes: [PlaceLocation]?
    
    // MARK: Actions
    @IBAction func unwindToMap(unwindSegue: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Show CollectViewController when pin tapped
        self.mapView.delegate = self
        mapView.showsUserLocation = true
        
        // Get the current location of the user
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
    
        // Annotation location (test)
        let cafeAnnotation = CafesLocation(title: "Groene Vlinder", coordinate: CLLocationCoordinate2D(latitude: 51.518177, longitude: -0.129098))
        mapView.addAnnotation(cafeAnnotation)
        
    }
    
    // Declare region
    func setUpGeofenceForGroeneVlinder() {
        let geofenceRegionCenter = CLLocationCoordinate2DMake(51.518177, -0.129098);
        let geofenceRegion = CLCircularRegion(center: geofenceRegionCenter, radius: 10, identifier: "Groene Vlinder");
        geofenceRegion.notifyOnExit = true;
        geofenceRegion.notifyOnEntry = true;
        
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let mapRegion = MKCoordinateRegion(center: geofenceRegionCenter, span: span)
        self.mapView.setRegion(mapRegion, animated: true)
        
        let regionCircle = MKCircle(center: geofenceRegionCenter, radius: 10)
        self.mapView.add(regionCircle)
        self.mapView.showsUserLocation = true;
        
        self.locationManager.startMonitoring(for: geofenceRegion)
    }
    
    // Set up geofence
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.authorizedAlways) {
            self.setUpGeofenceForGroeneVlinder()
        }
    }
    
    // Start monitoring
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("Started Monitoring Region")
    }
    
    // If the user entered the region, go to de CollectViewController
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        performSegue(withIdentifier: "CollectSegue", sender: nil)
    }
    
    // Exit the region
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Did exit")
    }
    
    // Draw circle of the region
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let overlayRenderer : MKCircleRenderer = MKCircleRenderer(overlay: overlay);
        overlayRenderer.lineWidth = 4.0
        overlayRenderer.strokeColor = UIColor(red: 7.0/255.0, green: 106.0/255.0, blue: 255.0/255.0, alpha: 1)
        overlayRenderer.fillColor = UIColor(red: 0.0/255.0, green: 203.0/255.0, blue: 208.0/255.0, alpha: 0.7)
        return overlayRenderer
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
}

// Go to the CollectViewController when the pin is tapped
//extension MapViewController: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        performSegue(withIdentifier: "CollectSegue", sender: nil)
//    }
//}


