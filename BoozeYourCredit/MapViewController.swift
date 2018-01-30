//
//  MapViewController.swift
//  BoozeYourCredit
//
//  On this screen the user can find the bar they are at.
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
    var userLocation: CLLocation?
    var locationManager = CLLocationManager()
            
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
                let cafeAnnotation = AnnotationCafes(title: cafe.title!, coordinate: cafe.coordinate)
                self.mapView.addAnnotation(cafeAnnotation)
            }
        }
    }
    
    // MARK: Actions
    @IBAction func unwindToMap(unwindSegue: UIStoryboardSegue) {
        
    }
    
    // Update the current location and zoom in on current location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0] as CLLocation
        self.userLocation = locations.first
        
        let coordinations = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,longitude: userLocation.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.5, 0.5)
        let region = MKCoordinateRegion(center: coordinations, span: span)
        
        self.mapView.showsUserLocation = true
        mapView.setRegion(region, animated: true)
    }
    
    // Update location failed, give an error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    // Function for a message
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? AnnotationCafes else { return nil }
        let identifier = "marker"
        var view: MKMarkerAnnotationView

        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
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
        
        // Get coordinates of the tapped marker
        let markerCoordinates = view.annotation?.coordinate
        let getLat: CLLocationDegrees = markerCoordinates!.latitude
        let getLon: CLLocationDegrees = markerCoordinates!.longitude
        let convertedCoordinates: CLLocation = CLLocation(latitude: getLat, longitude: getLon)
    
        // Calculate distance between the location of the user and the cafe
        if let userLocation = self.userLocation {
            let distance: CLLocationDistance = convertedCoordinates.distance(from: userLocation)
            if distance < 5 {
            performSegue(withIdentifier: "CollectSegue", sender: nil)
            } else {
                showAlert(title: "Hi!", message: "Sorry, you are not close enough to this café")
            }
        }
    }
}

