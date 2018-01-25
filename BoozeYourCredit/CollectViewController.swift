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

    // MARK: Outlets
    @IBOutlet weak var timerLabel: UILabel!
    
    // MARK: Properties
    var ref = Database.database().reference(withPath: "numberOfCredits")
    let userOnline = Auth.auth().currentUser?.email
    var numberOfCredits = 0
    var counter = 100
    var timer = Timer()
    
    // MARK: Actions
    @IBAction func collectButtonTapped(_ sender: UIButton) {
        // If the timer is 0, the user can collect a credit
        if counter == 0 {
            numberOfCredits += 1
        }
        
        // Save the score of the user
        guard let userOnline = userOnline else { return }
        let credits = Credit(name: userOnline, credit: numberOfCredits)
        self.ref.childByAutoId().setValue(credits.toAnyObject())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @ objc func timerAction() {
        counter -= 1
        timerLabel.text = "\(counter)"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Send the amount of correct answers to the next screen
        if segue.identifier == "indexSegue" {
            let indexViewController = segue.destination as! IndexViewController
            indexViewController.numberOfCredits = numberOfCredits
        }
    }
}
