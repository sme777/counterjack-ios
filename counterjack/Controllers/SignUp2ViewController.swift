//
//  SignUp2ViewController.swift
//  counterjack
//
//  Created by Samson Petrosyan on 11/9/20.
//  Copyright © 2020 Samson Petrosyan. All rights reserved.
//

import UIKit
import Firebase

class SignUp2ViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameErrorLabel: UILabel!
    @IBOutlet weak var signupButton: UIButton!
    
    var name: String!
    var password: String!
    var email: String!
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    override func viewDidLoad() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 5
        usernameErrorLabel.isHidden = true
    }
    @IBAction func signupButtonPressed(_ sender: UIButton) {
        validateUsername()
        if usernameErrorLabel.isHidden {
            
            
            auth.createUser(withEmail: email, password: password) { (res, err) in
                if let e = err {
                    print(e.localizedDescription)
                }
                if let r = res {
                    let id = r.user.uid
                    //w/o picture
                    self.db.collection("Users").document(id).setData([
                        "Name" : self.name!,
                        "Email" : self.email!,
                        "ID" : id,
                        "Creation" : Date().timeIntervalSince1970,
                        "Friends" : [String](),
                        "Rank" : 0,
                        "Posts" : [String : Any](),
                        "Karma" : 0
                    
                    ]) { (err) in
                        if let e = err {
                            print(e.localizedDescription)
                        }
                    }
                }
                //probably should add here
            }
            
            
            
            
            performSegue(withIdentifier: K.Segues.finishSignUp, sender: self)
        }
    }
    
    //makes a call to the db to check if a username is taken
    func validateUsername() {
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
}
