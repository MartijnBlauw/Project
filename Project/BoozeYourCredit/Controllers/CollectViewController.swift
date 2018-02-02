//
//  CollectViewController.swift
//  BoozeYourCredit
//
//  On this screen the user can collect their credits.
//
//  Created by Martijn Blauw on 11-01-18.
//  Copyright © 2018 Martijn Blauw. All rights reserved.
//

import UIKit
import Firebase

class CollectViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var cafeNameLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var collectButton: UIButton!
    
    // MARK: Properties
    var ref = Database.database().reference(withPath: "numberOfCredits")
    let userOnline = Auth.auth().currentUser
    var currentCoins: Int?
    var seconds = 10
    var timer = Timer()
    var cafeName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display name of the cafe
        guard let cafeName = cafeName else { return }
        cafeNameLabel.text = "\(cafeName)"
        
        // Change design button
        collectButton.layer.cornerRadius = 8
        
        // Trigger the timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer),
                                     userInfo: nil, repeats: true)
    }
    
    // If the timer is 0, the user can collect a credit and update saldo in Firebase
    @IBAction func collectButtonTapped(_ sender: UIButton) {
        if seconds == 0 {
            guard let userid = userOnline?.uid  else { return }
            
            let coinRef = ref.child(userid).child("credit")
            
            coinRef.observeSingleEvent(of: .value) { (snapshot) in
                if snapshot.value != nil {
                    self.currentCoins = snapshot.value as? Int
                    coinRef.setValue(self.currentCoins! + 1)
                } else {
                    self.currentCoins = 1
                    coinRef.setValue(self.currentCoins)
                }
            }
            performSegue(withIdentifier: "indexSegue", sender: nil)
        } else {
            present(ShowAlertController.shared.showAlert(title: "",
                                                         message: "You have to wait a little bit longer"),
                    animated: true)
        }
    }
    
    // Update the timer every second
    @ objc func updateTimer() {
        self.seconds -= 1
        if self.seconds == 0 {
            self.timer.invalidate()
        }
        timerLabel.text = timeString(time: TimeInterval(seconds))
    }
    
    // Convert seconds to minutes and hours
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%02i:%02i", minutes, seconds)
    }
}
