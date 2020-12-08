//
//  SignUp2ViewController.swift
//  counterjack
//
//  Created by Samson Petrosyan on 11/9/20.
//  Copyright © 2020 Samson Petrosyan. All rights reserved.
//

import UIKit
import Firebase


class SignUp2ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameErrorLabel: UILabel!
    @IBOutlet weak var signupButton: UIButton!
    
    var name: String!
    var password: String!
    var email: String!
    //var addProfileImage: Bool = false
    var image: UIImage? = nil
    //var call = DatabaseCalls()
    //let realm = try! Realm()
    
    private var imagePicker = UIImagePickerController()
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    override func viewDidLoad() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 5
        usernameErrorLabel.isHidden = true
        
        //print(Realm.Configuration.defaultConfiguration.fileURL! )
        //image picker
        imagePicker.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignUp2ViewController.profileImageSelect))
        profileImageView.addGestureRecognizer(tap)
        profileImageView.isUserInteractionEnabled = true
    }
    
    
    @objc func profileImageSelect() {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func signupButtonPressed(_ sender: UIButton) {
        validateUsername()
        if usernameErrorLabel.isHidden {
            
            
            //TODO: persist on a local db
            
            //newUser.profile = some_local_storage_url
            //self.realm.add(newUser)
            
            
            auth.createUser(withEmail: email, password: password) { (res, err) in
                if let e = err {
                    print(e.localizedDescription)
                }
                if let r = res {
                    let id = r.user.uid
                    let date: TimeInterval = Date().timeIntervalSince1970
                    
                    //local persistance
//                    let newUser = User()
//                    newUser.name = self.name!
//                    newUser.email = self.email!
//                    newUser.id = id
//                    newUser.date = date
//                    self.realm.add(newUser)
                    //w/o picture
                    
                    if let profileImage = self.image {
                        
                        let imageData = profileImage.jpegData(compressionQuality: 0.4)
                                   
                        
                        let storageRef = Storage.storage().reference(forURL: "gs://counterjack-blackjack.appspot.com")
                        
                        
                        let storageLink = DatabaseCalls.randomStorageRefGenerator()
                        let storageProfileRef = storageRef.child(id).child("Profile").child(storageLink)
                                       
                            let metadata = StorageMetadata()
                            metadata.contentType = "image/jpg"
                            
                            storageProfileRef.putData(imageData!, metadata: metadata, completion: {storage, error in
                                if let e = error {
                                    print(e.localizedDescription)
                                    return
                                }
                                storageProfileRef.downloadURL { url, error in
                                    if let e = error {
                                        print(e.localizedDescription)
                                        return
                                    }
                                    self.db.collection("Users").document(id).setData([
                                        "Name" : self.name!,
                                        "Email": self.email!,
                                        "ID": id,
                                        "Creation": date,
                                        "Friends": [String](),
                                        "Rank": 0,
                                        "Posts": [String : Any](),
                                        "Karma": 0,
                                        "Profile Image" : url!.absoluteString
                                    ]) { err in
                                        if let e = err {
                                            print(e.localizedDescription)
                                        }
                                    }
                                }
                            })
                        
                    } else {
                    
                        self.db.collection("Users").document(id).setData([
                            "Name" : self.name!,
                            "Email" : self.email!,
                            "ID" : id,
                            "Creation" : date,
                            "Friends" : [String](),
                            "Rank" : 0,
                            "Posts" : [String : Any](),
                            "Karma" : 0,
                            "Profile Image" : ""
                        
                        ]) { (err) in
                            if let e = err {
                                print(e.localizedDescription)
                            }
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

extension SignUp2ViewController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        profileImageView.contentMode = .scaleAspectFill
        //addProfileImage = true
        image = profileImageView.image!
        self.dismiss(animated: true, completion: nil)
    }
}


