//
//  StartGameViewController.swift
//  counterjack
//
//  Created by Samson Petrosyan on 12/4/20.
//  Copyright © 2020 Samson Petrosyan. All rights reserved.
//

import UIKit
import SideMenu

class StartGameViewController: UIViewController {
    
    
    @IBOutlet weak var againButton: UIButton!
    @IBOutlet weak var roundResultLabel: UILabel!
    @IBOutlet weak var sideBetsButton: UIButton!
    @IBOutlet weak var splitButton: UIButton!
    @IBOutlet weak var surrenderButton: UIButton!
    @IBOutlet weak var standButton: UIButton!
    @IBOutlet weak var doubleButton: UIButton!
    @IBOutlet weak var hitButton: UIButton!
    var game: Game? = nil
    var uicardsRemaining: Array<UIView> = []
    var uicardsInPlay: [PlayerInterface : Array<UIView>] = [:]
    var hitCount = 0
    var firstRow = 0
    //let menu: SideMenuNavigationController?
    override func viewDidLoad() {
        game = Game(deckNumber: 2)
        roundResultLabel.isHidden = true
        againButton.isHidden = true
        hitButton.layer.borderWidth = 1
        hitButton.layer.borderColor = #colorLiteral(red: 0.2754207253, green: 0.331106782, blue: 0.3982514143, alpha: 1)
        hitButton.layer.cornerRadius = hitButton.frame.size.height / 6
        doubleButton.layer.borderWidth = 1
        doubleButton.layer.borderColor = #colorLiteral(red: 0.2754207253, green: 0.331106782, blue: 0.3982514143, alpha: 1)
        doubleButton.layer.cornerRadius = doubleButton.frame.size.height / 6
        againButton.layer.cornerRadius = againButton.frame.size.height / 4
        
        //side bet creation
//        let vc = SideMenuManager()
//        vc.dele
        //let menu = SideMenuNavigationController(rootViewController: StartGameViewController)
        
        
        //function calls
        configureButtons()
        loadDeck()
        distributeCards()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    
    func distributeCards() {


        
//        hitButtonPressed(hitButton, initial: true)
//        //let _ = game?.addPlayerCard()
//
//        let topCard = game?.popTopCard()
//        let topCardView = uicardsRemaining.remove(at: uicardsRemaining.endIndex - 1)
//
//        uicardsInPlay[(game?.getDealer())!] = [topCardView]
//        let frontImage = UIImage(named: topCard!.face + topCard!.suit)
//        let frontImageView = UIImageView(image: frontImage!)
//        frontImageView.frame = topCardView.subviews[0].frame
//        let _ = game?.addPlayerCard(topCard!, initial: true)
//        animateCard(x: 135, y: 100, front: frontImageView, back: topCardView)
//
//        hitButtonPressed(hitButton, initial: true)
//
//        let topCard2 = game?.popTopCard()
//        let topCardView2 = uicardsRemaining.remove(at: uicardsRemaining.endIndex - 1)
//        uicardsInPlay[(game?.getDealer())!]!.append(topCardView2)
//        let _ = game?.addPlayerCard(topCard2!, initial: true)
//        animateCard(x: 145, y: 100, front: nil, back: topCardView2, willFlip: false)
        giveInitialPlayerCard(x: 125, y: 550)
        
        giveInitialDealerCard(x: 135, y: 100)
        
        giveInitialPlayerCard(x: 145, y: 550)
        //sleep(2)
        giveInitialDealerCard(x: 155, y: 100, second: true)
        
    }
    
    
    func giveInitialPlayerCard(x: CGFloat, y: CGFloat) {
        let topCard = game?.popTopCard()
        let topCardView = uicardsRemaining.remove(at: uicardsRemaining.endIndex - 1)
        
        let frontImage = UIImage(named: topCard!.face + topCard!.suit)
        let frontImageView = UIImageView(image: frontImage!)
        frontImageView.frame = topCardView.subviews[0].frame
        let _ = game?.addPlayerCard(topCard!, initial: true)
        animateCard(x: x, y: y, front: frontImageView, back: topCardView)
        //uicardsInPlay[]
    }
    
    
    func giveInitialDealerCard(x: CGFloat, y: CGFloat, second: Bool = false) {
        let topCard = game?.popTopCard()
        let topCardView = uicardsRemaining.remove(at: uicardsRemaining.endIndex - 1)
        if uicardsInPlay[game!.getDealer()] == nil {
            uicardsInPlay[(game?.getDealer())!] = [topCardView]
        } else {
            uicardsInPlay[(game?.getDealer())!]?.append(topCardView)
        }
        
            //= [topCardView]
        let frontImage = UIImage(named: topCard!.face + topCard!.suit)
        let frontImageView = UIImageView(image: frontImage!)
        frontImageView.frame = topCardView.subviews[0].frame
        let _ = game?.addPlayerCard(topCard!, initial: true)
        if second {
            animateCard(x: x, y: y, front: nil, back: topCardView, willFlip: false)
        } else {
            animateCard(x: x, y: y, front: frontImageView, back: topCardView)
        }
        
        
    }
    
    func giveInitialAICard() {
        
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
            uicardsRemaining.append(someView)
            view.addSubview(someView)
        }
    }
    
    func animateCard(x: CGFloat, y: CGFloat, front: UIImageView?, back: UIView, willFlip: Bool = true, willRotate: Bool = false) {
//        UIView.animate(withDuration: 2, delay: 2, options: UIView.AnimationOptions.curveEaseIn, animations: {
//            if willRotate {
//                back.transform = CGAffineTransform(rotationAngle: (90 * .pi) / 180)
//            }
//            
//            if self.hitCount > 3 {
//                back.frame.origin.y += 620
//            } else {
//                back.frame.origin.y += y
//            }
//            back.frame.origin.x += (x + CGFloat(self.hitCount % 4) * 25)
//            self.view.bringSubviewToFront(back)
//        }) { (trans) in
//            if willFlip {
//                UIView.transition(from: back.subviews[0], to: front!, duration: 0.3, options: .transitionFlipFromLeft, completion: nil)
//            }
//        }
        UIView.animate(withDuration: 2, animations: {

            if willRotate {
                back.transform = CGAffineTransform(rotationAngle: (90 * .pi) / 180)
            }

            if self.hitCount > 3 {
                back.frame.origin.y += 620
            } else {
                back.frame.origin.y += y
            }
            back.frame.origin.x += (x + CGFloat(self.hitCount % 4) * 25)
            self.view.bringSubviewToFront(back)

        }) { (trans) in
            if willFlip {
                UIView.transition(from: back.subviews[0], to: front!, duration: 0.3, options: .transitionFlipFromLeft, completion: nil)
            }
        }
    }
    
    func calculateAction(card: Card, double: Bool = false, initial: Bool = false) {
        let count = game!.addPlayerCard(card, initial: initial)
        
        if double {
            self.hitButton.isEnabled = false
            self.doubleButton.isEnabled = false
            self.standButton.isEnabled = false
            self.surrenderButton.isEnabled = false
            dealRest()
            roundResultLabel.text = "You Lost!"
            roundResultLabel.isHidden = false
            againButton.isHidden = false
        }
        
        if count > 21 {
            self.hitButton.isEnabled = false
            self.doubleButton.isEnabled = false
            self.standButton.isEnabled = false
            self.surrenderButton.isEnabled = false
            dealRest()
            roundResultLabel.text = "You Lost!"
            roundResultLabel.isHidden = false
            againButton.isHidden = false
            
        } else if count == 21 {
            //smth
            let alert = UIAlertController(title: "Alert", message: "Blackjack", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            dealRest()
            if GameFunctions.count(game!.getDealerCards()) == 21 {
                roundResultLabel.text = "It's a Draw!"
            } else {
                roundResultLabel.text = "You Won!"
            }
            roundResultLabel.isHidden = false
            againButton.isHidden = false
        }
        
        
    }
    
    func dealRest() {
        let delearUICards = uicardsInPlay[game!.getDealer()]
        let lastCard = game!.getLastDealerCard()
        let frontImage = UIImage(named: lastCard.face + lastCard.suit)
        let frontImageView = UIImageView(image: frontImage!)
        frontImageView.frame = delearUICards![1].subviews[0].frame
        UIView.transition(from: delearUICards![1].subviews[0], to: frontImageView, duration: 0.3, options: .transitionFlipFromTop, completion: nil)
        
        
        while GameFunctions.count((game?.getDealerCards())!) < 17 {
            let topCard = game?.popTopCard()
            let topCardView = uicardsRemaining.remove(at: uicardsRemaining.endIndex - 1)
            
            uicardsInPlay[(game?.getDealer())!]!.append(topCardView)
            let frontImage = UIImage(named: topCard!.face + topCard!.suit)
            let frontImageView = UIImageView(image: frontImage!)
            frontImageView.frame = topCardView.subviews[0].frame
            let _ = game?.addPlayerCard(topCard!, initial: true)
            animateCard(x: 175, y: 100, front: frontImageView, back: topCardView)
            let _ = game?.addPlayerCard(topCard!)
        }
    }
    
    
    @IBAction func hitButtonPressed(_ sender: UIButton, initial: Bool = false) {
        let topCard = game?.popTopCard()
        let topCardView = uicardsRemaining.remove(at: uicardsRemaining.endIndex - 1)
        let currPlayer = game!.getCurrentPlayerInterface()
        if uicardsInPlay[currPlayer] == nil {
            uicardsInPlay[currPlayer] = [topCardView]
        } else {
            uicardsInPlay[currPlayer]?.append(topCardView)
        }
        //uicardsInPlay.append(topCardView)
        let frontImage = UIImage(named: topCard!.face + topCard!.suit)
        let frontImageView = UIImageView(image: frontImage!)
        frontImageView.frame = topCardView.subviews[0].frame
        //let _ = game?.addPlayerCard(topCard!, initial: initial)
        animateCard(x: 165, y: 550, front: frontImageView, back: topCardView)
        
        calculateAction(card: topCard!, initial: initial)

        self.hitCount += 1
    }
    
    
    @IBAction func doubleButtonPressed(_ sender: UIButton) {
        
        let topCard = game?.popTopCard()
        let topCardView = uicardsRemaining.remove(at: uicardsRemaining.endIndex - 1)
        let currPlayer = game!.getCurrentPlayerInterface()
        if uicardsInPlay[currPlayer] == nil {
            uicardsInPlay[currPlayer] = [topCardView]
        } else {
            uicardsInPlay[currPlayer]?.append(topCardView)
        }
        let frontImage = UIImage(named: topCard!.face + topCard!.suit)
        let frontImageView = UIImageView(image: frontImage!)
        frontImageView.frame = topCardView.subviews[0].frame
        
        animateCard(x: 125, y: 550, front: frontImageView, back: topCardView, willFlip: true, willRotate: true)
        //let _ = game?.addPlayerCard(topCard!)
        calculateAction(card: topCard!, double: true)
        game?.removeFromQueue()
        dealRest()
    }
    
    @IBAction func standButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func surrenderButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func splitButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func againButtonPressed(_ sender: UIButton) {
        againButton.isHidden = true
        roundResultLabel.isHidden = true
    }
}
