//
//  CollectViewController.swift
//  BoozeYourCredit
//
//  Created by Martijn Blauw on 11-01-18.
//  Copyright © 2018 Martijn Blauw. All rights reserved.
//

import UIKit
import Firebase

class CollectViewController: UIViewController {

    // MARK: Properties
    var ref = Database.database().reference(withPath: "numberOfCredits")
    let userOnline = Auth.auth().currentUser?.email
    var numberOfCredits = 0
    
    // MARK: Actions
    @IBAction func collectButtonTapped(_ sender: UIButton) {
        numberOfCredits += 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Save the score of the user
        guard let userOnline = userOnline else { return }
        let credits = Credit(name: userOnline, credit: numberOfCredits)
        self.ref.childByAutoId().setValue(credits.toAnyObject())

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Send the amount of correct answers to the next screen
        if segue.identifier == "indexSegue" {
            let indexViewController = segue.destination as! IndexViewController
            indexViewController.numberOfCredits = numberOfCredits
        }
    }
}
