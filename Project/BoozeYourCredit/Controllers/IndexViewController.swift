//
//  IndexViewController.swift
//  BoozeYourCredit
//
//  This is the index screen, where the user can see their saldo and cash out their credits in exchange for a drink.
//
//  Created by Martijn Blauw on 11-01-18.
//  Copyright © 2018 Martijn Blauw. All rights reserved.
//

import UIKit
import Firebase

class IndexViewController: UIViewController {
   
    // MARK: Outlets
    @IBOutlet weak var numberOfCreditsLabel: UILabel!
    @IBOutlet weak var freeDrinkButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    // MARK: Properties
    var cafes = [PlaceLocation]()
    var ref = Database.database().reference(withPath: "numberOfCredits")
    let userOnline = Auth.auth().currentUser
    var currentCoins: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        freeDrinkButton.layer.cornerRadius = 8
        searchButton.layer.cornerRadius = 8
        
        updateSaldo()
    }
    
    // Go to the MapViewController only if all data is loaded
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        PlaceController.shared.loadCafes() { (cafes) in
            if let cafes = cafes {
                self.cafes = cafes
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "mapSegue", sender: self)
                }
            }
        }
    }
        
    // Check saldo user, update saldo in Firebase or give an error message
    @IBAction func freeDrinkButtonTapped(_ sender: UIButton) {
        guard let userid = userOnline?.uid  else { return }
        
        let coinRef = ref.child(userid).child("credit")
        
        coinRef.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.value != nil && (snapshot.value as! Int) >= 10 {
                    self.currentCoins = snapshot.value as? Int
                    coinRef.setValue(self.currentCoins! - 10)
            } else {
                self.present(ShowAlertController.shared.showAlert(title: "Sorry", message: "You have not 10 credits yet"), animated: true)
            }
        }
    }
    
    // Go back to IndexViewController
    @IBAction func unwindToIndex(unwindSegue: UIStoryboardSegue) {
        
    }
    
    // Log out
    @IBAction func logOutButton(_ sender: UIButton) {
        try? Auth.auth().signOut()
        performSegue(withIdentifier: "loginSegue", sender: self)
    }
    
    // Display number of credits
    func updateSaldo() {
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
            let destination = segue.destination as! UINavigationController
            let mapViewController = destination.topViewController as! MapViewController
            mapViewController.cafes = cafes
        }
    }
}
