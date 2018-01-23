//
//  CollectViewController.swift
//  BoozeYourCredit
//
//  Created by Martijn Blauw on 11-01-18.
//  Copyright © 2018 Martijn Blauw. All rights reserved.
//

import UIKit

class CollectViewController: UIViewController {

    // MARK: Properties
    var numberOfCredits = 0
    
    // MARK: Actions
    @IBAction func collectButtonTapped(_ sender: UIButton) {
        numberOfCredits += 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Send the amount of correct answers to the next screen
        if segue.identifier == "indexSegue" {
            let indexViewController = segue.destination as! IndexViewController
            indexViewController.numberOfCredits = numberOfCredits
        }
    }
}
