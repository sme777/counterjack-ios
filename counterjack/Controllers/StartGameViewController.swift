//
//  StartGameViewController.swift
//  counterjack
//
//  Created by Samson Petrosyan on 12/4/20.
//  Copyright © 2020 Samson Petrosyan. All rights reserved.
//

import UIKit

class StartGameViewController: UIViewController {
    
    
    @IBOutlet weak var sideBetsButton: UIButton!
    @IBOutlet weak var splitButton: UIButton!
    @IBOutlet weak var surrenderButton: UIButton!
    @IBOutlet weak var standButton: UIButton!
    @IBOutlet weak var doubleButton: UIButton!
    @IBOutlet weak var hitButton: UIButton!
    var game: Game? = nil
    
    override func viewDidLoad() {
        game = Game(deckNumber: 2)
        
        hitButton.layer.borderWidth = 1
        hitButton.layer.borderColor = #colorLiteral(red: 0.2754207253, green: 0.331106782, blue: 0.3982514143, alpha: 1)
        hitButton.layer.cornerRadius = hitButton.frame.size.height / 6
        doubleButton.layer.borderWidth = 1
        doubleButton.layer.borderColor = #colorLiteral(red: 0.2754207253, green: 0.331106782, blue: 0.3982514143, alpha: 1)
        doubleButton.layer.cornerRadius = doubleButton.frame.size.height / 6
        
        configureButtons()
        loadDeck()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    
    func configureButtons() {
        splitButton.isEnabled = false
        sideBetsButton.isEnabled = false
    }
    
    
    func loadDeck() {
        let numberOfCards = game!.getDeckCount()
        for i in 0..<numberOfCards {
            let image = UIImage(named: "gray_back")
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: 40 - i/4, y: 100 - i/4, width: 80, height: 120)
            view.addSubview(imageView)
        }
    }
    
    @IBAction func hitButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func doubleButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func standButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func surrenderButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func splitButtonPressed(_ sender: UIButton) {
    }
}
