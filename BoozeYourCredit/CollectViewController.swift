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
    let userOnline = Auth.auth().currentUser
    var currentCoins: Int?
    var seconds = 5
    var timer = Timer()

    // MARK: Actions
    @IBAction func collectButtonTapped(_ sender: UIButton) {
        
        // If the timer is 0, the user can collect a credit
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
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Trigger the timer
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    // Update the timer every second
    @ objc func updateTimer() {
        self.seconds -= 1
        if self.seconds <= 0 {
            self.timer.invalidate()
            self.seconds = 0
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
