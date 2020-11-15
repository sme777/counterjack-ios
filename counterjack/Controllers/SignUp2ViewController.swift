//
//  SignUp2ViewController.swift
//  counterjack
//
//  Created by Samson Petrosyan on 11/9/20.
//  Copyright © 2020 Samson Petrosyan. All rights reserved.
//

import UIKit

class SignUp2ViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameErrorLabel: UILabel!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 5
        usernameErrorLabel.isHidden = true
    }
    @IBAction func signupButtonPressed(_ sender: UIButton) {
        validateUsername()
        if usernameErrorLabel.isHidden {
            performSegue(withIdentifier: K.Segues.finishSignUp, sender: self)
        }
    }
    
    //makes a call to the db to check if a username is taken
    func validateUsername() {
        
    }
}
