//
//  ViewController.swift
//  counterjack
//
//  Created by Samson Petrosyan on 11/8/20.
//  Copyright © 2020 Samson Petrosyan. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signUpWithFacebookButton: UIButton!
    @IBOutlet weak var signUpWithGoogleButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //corner radius, width, and color for log in button
        signInButton.layer.cornerRadius = signInButton.frame.size.height / 2
        signInButton.layer.borderWidth = 1
        signInButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        //corner radius, width, and color for sign up button
        signUpButton.layer.cornerRadius = signUpButton.frame.size.height / 2
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        //corner radius, with, and color for sign up w/ facebook
        signUpWithFacebookButton.layer.cornerRadius = signUpWithFacebookButton.frame.size.height / 2
        signUpWithFacebookButton.layer.borderWidth = 1
        signUpWithFacebookButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        //corner radius, with, and color for sign up w/ google
        signUpWithGoogleButton.layer.cornerRadius = signUpWithGoogleButton.frame.size.height / 2
        signUpWithGoogleButton.layer.borderWidth = 1
        signUpWithGoogleButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }


}

