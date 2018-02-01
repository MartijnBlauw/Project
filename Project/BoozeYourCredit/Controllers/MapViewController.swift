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
    var locationManager = CLLocationManager()
    var userLocation: CLLocation?
    var cafeName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
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
    
    // Go back to the MapViewController
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
    
    // Send name of the cafe to the next screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "collectSegue" {
            let destination = segue.destination as! UINavigationController
            let collectViewController = destination.topViewController as! CollectViewController
            collectViewController.cafeName = cafeName
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // Check if this annotation is an AnnotationCafes object and create a marker annotation view
        guard let annotation = annotation as? AnnotationCafes else { return nil }
        let identifier = "marker"
        var view: MKMarkerAnnotationView

        // Check if a reusable annotation view is available
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        // Create new MKMarkerAnnotationView object
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

        // Calculate distance between the location of the user and the tapped marker
        if let userLocation = self.userLocation {
            let distance: CLLocationDistance = convertedCoordinates.distance(from: userLocation)
            if distance < 5 {
            self.cafeName = view.annotation?.title!
            performSegue(withIdentifier: "collectSegue", sender: nil)
            } else {
                present(ShowAlertController.shared.showAlert(title: "Hi!",
                                                             message: "Sorry, you are not close enough to this café"),
                                                                animated: true)
            }
        }
    }
}
