//
//  LoginViewController.swift
//  BoozeYourCredit
//
//  On this screen the user can register and log in.
//
//  Created by Martijn Blauw on 11-01-18.
//  Copyright © 2018 Martijn Blauw. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }
        }
    }
    
    // Register
    @IBAction func registerButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Register",
                                      message: "Please enter your email and password",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]

            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { user, error in
                if error != nil {
                    self.present(ShowAlertController.shared.showAlert(title: "Error", message: (error?.localizedDescription)!), animated: true)
                    return
                }
                
                guard let userid = user?.uid  else { return }
                
                Auth.auth().signIn(withEmail: self.textFieldLoginEmail.text!, password: self.textFieldLoginPassword.text!)
                
                let coinRef = Database.database().reference(withPath: "numberOfCredits").child(userid)
                let newSaldo = ["credit": 0]
                coinRef.updateChildValues(newSaldo, withCompletionBlock: { (error, coinRef) in
                    if error != nil {
                        print(error!)
                    }
                })
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // Login
    @IBAction func loginButton(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: textFieldLoginEmail.text!, password: textFieldLoginPassword.text!) { (user, error) in
            if error != nil {
                self.present(ShowAlertController.shared.showAlert(title: "Error", message: (error?.localizedDescription)!), animated: true)
            }
        }
    }
}

// Taking care of dismissal of the keyboard
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldLoginPassword {
            textFieldLoginPassword.becomeFirstResponder()
        }
        if textField == textFieldLoginPassword {
            textField.resignFirstResponder()
        }
        return true
    }
}


