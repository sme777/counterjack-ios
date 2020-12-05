//
//  HomeViewController.swift
//  counterjack
//
//  Created by Samson Petrosyan on 11/23/20.
//  Copyright © 2020 Samson Petrosyan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var lastGameButton: UIButton!
    @IBOutlet weak var playOnlineButton: UIButton!
    //@IBOutlet weak var checkbox: UIButton!
    @IBOutlet weak var checkbox: UIImageView!
    var isChecked: Bool = false
    override func viewDidLoad() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.checkboxSelect))
        checkbox.addGestureRecognizer(tap)
        checkbox.isUserInteractionEnabled = true
    }
    
    @objc func checkboxSelect() {
        if isChecked {
            self.checkbox.image = UIImage(named: "unchecked_checkbox")
            self.isChecked = false
        } else {
            checkbox.image = UIImage(named: "checked_checkbox")
            self.isChecked = true
        }
    }
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.newGame, sender: self)
    }
    @IBAction func lastGameButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.lastGame, sender: self)
    }
    @IBAction func playOnlineButtonPressed(_ sender: UIButton) {
    }
//    @IBAction func checkboxPressed(_ sender: UIButton) {
//        print("This gets run")
//        checkbox.imageView?.image = UIImage(named: "checked_checkbox")
//    }
}
