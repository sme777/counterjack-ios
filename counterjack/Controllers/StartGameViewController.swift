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
    var uicards: Array<UIView> = []
    var hitCount = 0
    var firstRow = 0
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
            let backImage = UIImage(named: "gray_back")
            let backImageView = UIImageView(image: backImage!)
            let rect  = CGRect(x: 40 - i/4, y: 100 - i/4, width: 80, height: 120)
            backImageView.frame = CGRect(x: 0, y: 0, width: 80, height: 120)
            
            let someView = UIView(frame: rect)
            someView.addSubview(backImageView)
            uicards.append(someView)
            view.addSubview(someView)
        }
    }
    
    @IBAction func hitButtonPressed(_ sender: UIButton) {
        let topCard = game?.popTopCard()
        let topCardView = uicards.remove(at: uicards.endIndex - 1)
        
        let frontImage = UIImage(named: topCard!.face + topCard!.suit)
        let frontImageView = UIImageView(image: frontImage!)
        frontImageView.frame = topCardView.subviews[0].frame
        
        UIView.animate(withDuration: 2, animations: {
            if self.hitCount > 3 {
                topCardView.frame.origin.y += 620
            } else {
                topCardView.frame.origin.y += 550
            }
            topCardView.frame.origin.x += (125 + CGFloat(self.hitCount % 4) * 25)
            self.view.bringSubviewToFront(topCardView)
            
        }) { (trans) in
            UIView.transition(from: topCardView.subviews[0], to: frontImageView, duration: 0.3, options: .transitionFlipFromLeft, completion: nil)
        }
        
        
        
        self.hitCount += 1
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
