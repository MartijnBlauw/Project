//
//  IndexViewController.swift
//  BoozeYourCredit
//
//  Created by Martijn Blauw on 11-01-18.
//  Copyright © 2018 Martijn Blauw. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class IndexViewController: UIViewController {
   
    // MARK: Outlets
    @IBOutlet weak var numberOfCreditsLabel: UILabel!
    
    // MARK: Properties
    var numberOfCredits: Int?
    var cafes = [PlaceLocation]()
    
    // Go back to Index View Controller
    @IBAction func unwindToIndex(unwindSegue: UIStoryboardSegue) {
    
    }
    
    // Collect a free drink and show a message if the user has not enough credits
    @IBAction func freeDrinkButtonTapped(_ sender: UIButton) {
        guard let _ = numberOfCredits else { return }
        if numberOfCredits! >= 10 {
            numberOfCredits! -= 10
        } else {
            let alertController = UIAlertController(title: "Hey", message: "Sorry, you have not enought coins for a drink", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
    // Log out
    @IBAction func logOutButton(_ sender: UIButton) {
        try? Auth.auth().signOut()
        performSegue(withIdentifier: "backToBegin", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load data from the API
        PlaceController.shared.loadCafes() { (cafes) in
            if let cafes = cafes {
                self.cafes = cafes
            }
        }
        
        // Display number of credits
        guard let numberOfCredits = numberOfCredits else { return }
        numberOfCreditsLabel.text = "\(numberOfCredits)"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Send the data of the API to the next screen
        if segue.identifier == "mapSegue" {
            let desti = segue.destination as! UINavigationController
            let mapViewController = desti.topViewController as! MapViewController
            mapViewController.cafes = cafes
        }
    }
}
