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
    
    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: Properties
    var cafes: [PlaceLocation]?
    var locationManager = CLLocationManager()
    var isInRegion: Bool = false
    
    // MARK: Actions
    @IBAction func unwindToMap(unwindSegue: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mapView.delegate = self
        
        // Get the current location of the user
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        // Load the markers on the map
        if let cafes = cafes {
            for cafe in cafes {
                let cafeAnnotation = CafesLocation(title: cafe.title!, coordinate: cafe.coordinate)
                self.mapView.addAnnotation(cafeAnnotation)
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
        overlayRenderer.strokeColor = UIColor(red: 0, green: 0.4863, blue: 0.6471, alpha: 1.0)
        overlayRenderer.fillColor = UIColor(red: 0, green: 0.4863, blue: 0.6471, alpha: 0.7)
        
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
        isInRegion = true
    }
    
    
    // Enter the region
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Did enter")
    }
    
    // Exit the region
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Did exit")
        isInRegion = false
    }
    
    // Check if the user is still in the region
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        if state == CLRegionState.inside {
            print("Still in the region")
        }
    }
    
    // Update the current location and zoom in on current location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0] as CLLocation

        let coordinations = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,longitude: userLocation.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.8, 0.8)
        let region = MKCoordinateRegion(center: coordinations, span: span)
        
        mapView.setRegion(region, animated: true)
    }
    
    // Update location failed, give an error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? CafesLocation else { return nil }
        let identifier = "marker"
        var view: MKMarkerAnnotationView

        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        if isInRegion == true {
            performSegue(withIdentifier: "CollectSegue", sender: nil)
        } else {
            return
        }
    }
}



