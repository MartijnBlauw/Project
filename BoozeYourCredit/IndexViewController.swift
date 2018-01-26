//
//  IndexViewController.swift
//  BoozeYourCredit
//
//  Created by Martijn Blauw on 11-01-18.
//  Copyright © 2018 Martijn Blauw. All rights reserved.
//

import UIKit
import Firebase

class IndexViewController: UIViewController {
   
    // MARK: Outlets
    @IBOutlet weak var numberOfCreditsLabel: UILabel!
    
    // MARK: Properties
    var ref = Database.database().reference(withPath: "numberOfCredits")
    let userOnline = Auth.auth().currentUser
    var currentCoins: Int?
    var cafes = [PlaceLocation]()
    
    // Go back to Index View Controller
    @IBAction func unwindToIndex(unwindSegue: UIStoryboardSegue) {
    
    }
    
    // Collect a free drink and show a message if the user has not enough credits (negative numbers)
    @IBAction func freeDrinkButtonTapped(_ sender: UIButton) {
        guard let userid = userOnline?.uid  else { return }
        
        let coinRef = ref.child(userid).child("credit")
        
        coinRef.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.value != nil {
                self.currentCoins = snapshot.value as? Int
                coinRef.setValue(self.currentCoins! - 10)
            } else {
                let alertController = UIAlertController(title: "Hey", message: "Sorry, you have not enought coins for a drink", preferredStyle: .alert)
    
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
    
                self.present(alertController, animated: true, completion: nil)
            }
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
        guard let userid = userOnline?.uid  else { return }
        
        let coinRef = ref.child(userid).child("credit")
        
        coinRef.observe(.value) { snapshot in
            self.currentCoins = snapshot.value as? Int
            if self.currentCoins != nil {
                let currentCoins = String(describing: self.currentCoins!)
                self.numberOfCreditsLabel.text = currentCoins
            } else {
                self.numberOfCreditsLabel.text = "0"
            }
        }
    }
    
    // Send the data of the API to the next screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapSegue" {
            let desti = segue.destination as! UINavigationController
            let mapViewController = desti.topViewController as! MapViewController
            mapViewController.cafes = cafes
        }
    }
}
