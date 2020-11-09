//
//  LoginViewController.swift
//  counterjack
//
//  Created by Samson Petrosyan on 11/8/20.
//  Copyright © 2020 Samson Petrosyan. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

class LoginViewController: UIViewController {
    @IBOutlet weak var emailOrUsernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordAreaView: UIView!
    @IBOutlet weak var emailOrUsernameAreaView: UIView!
    @IBOutlet weak var invalidCredentialsLabel: UILabel!
    
    override func viewDidLoad() {
        emailOrUsernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
            
        invalidCredentialsLabel.isHidden = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        if let email = emailOrUsernameTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if let _ = error {
                    DispatchQueue.main.async {
                        self.invalidCredentialsLabel.isHidden = false
                    }
                } else {
                    self.performSegue(withIdentifier: K.Segues.logIn, sender: self)
                }
                
            }
        } else {
            invalidCredentialsLabel.isHidden = false
        }
    }
    
}
