//
//  SignUp1ViewController.swift
//  counterjack
//
//  Created by Samson Petrosyan on 11/9/20.
//  Copyright © 2020 Samson Petrosyan. All rights reserved.
//

import UIKit
//import RealmSwift

class SignUp1ViewController: UIViewController {
    
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        
        
        //print(Realm.Configuration.defaultConfiguration.fileURL! )
        nameErrorLabel.isHidden = true
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        
        nameTextField.becomeFirstResponder()
    }
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        validateFields()
        if nameErrorLabel.isHidden && emailErrorLabel.isHidden && passwordErrorLabel.isHidden {
            performSegue(withIdentifier: K.Segues.continueSignUp, sender: self)
        }
        
        
        
    }
    
    func validateFields() {
        if let nameText = nameTextField.text {
            if !isAlpha(nameText) {
                nameErrorLabel.isHidden = false
            } else {
                nameErrorLabel.isHidden = true
            }
        } else {
            nameErrorLabel.isHidden = false
        }
        
        if let emailText = emailTextField.text {
            if !isValidEmail(emailText) {
                emailErrorLabel.isHidden = false
            } else {
                emailErrorLabel.isHidden = true
            }
        } else {
            emailErrorLabel.isHidden = false
        }
        
        if let passwordText = passwordTextField.text {
            if !isValidPassword(passwordText) {
                passwordErrorLabel.isHidden = false
            } else {
                passwordErrorLabel.isHidden = true
            }
        } else {
            passwordErrorLabel.isHidden = false
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SignUp2ViewController {
            let vc = segue.destination as! SignUp2ViewController
            vc.password = passwordTextField.text!
            vc.email = emailTextField.text!
            vc.name = nameTextField.text!
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    func isValidPassword(_ password: String) -> Bool {
        if password.count <= 8 {
            return false
        }
        if password.range(of: "[a-zA-Z0-9]*[a-z0-9]+[A-Z0-9]+[a-zA-Z0-9]*", options: .regularExpression, range: nil, locale: nil) == nil {
            return false
        }
        
        return true
    }

    func isAlpha(_ name: String) -> Bool {
        if name.range(of: "[a-zA-Z]+", options: .regularExpression, range: nil, locale: nil) == nil {
            return false
        }
        return true
    }

}

