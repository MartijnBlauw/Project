//
//  HelpViewController.swift
//  BoozeYourCredit
//
//  On this screen the user can find the manual of the app.
//
//  Created by Martijn Blauw on 11-01-18.
//  Copyright © 2018 Martijn Blauw. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var helpLabel1: UILabel!
    @IBOutlet weak var helpLabel2: UILabel!
    @IBOutlet weak var helpLabel3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rules()
    }
    
    // Text for the HelpViewController
    func rules() {
        helpLabel1.text = "1. You can use the map to find a bar."
        helpLabel2.text = "2. If you are more than 10 minutes in a particular bar, you can collect a credit."
        helpLabel3.text = "3. If you have collected more than 10 credits, you can get a free drink."
    }
}
