//
//  ShowAlertController.swift
//  BoozeYourCredit
//
//  Created by Martijn Blauw on 30-01-18.
//  Copyright © 2018 Martijn Blauw. All rights reserved.
//

import Foundation
import UIKit

class ShowAlertController {
    
    static let shared = ShowAlertController()

    func showAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        return alert
    }
}
