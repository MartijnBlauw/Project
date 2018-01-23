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
    
    // Log out
    @IBAction func logOutButton(_ sender: UIButton) {
        try? Auth.auth().signOut()
        performSegue(withIdentifier: "backToBegin", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display number of credits
        guard let numberOfCredits = numberOfCredits else { return }
        numberOfCreditsLabel.text = "\(numberOfCredits)"
        
        // Load data from the API
        PlaceController.shared.loadCafes() { (cafes) in
            if let cafes = cafes {
                self.cafes = cafes
            }
        }
    }
}
