//
//  NewGameSettingsViewController.swift
//  counterjack
//
//  Created by Samson Petrosyan on 12/4/20.
//  Copyright © 2020 Samson Petrosyan. All rights reserved.
//

import UIKit
import iOSDropDown

class NewGameSettingsViewController: UIViewController {
    
    var isPremium: Bool = false
    @IBOutlet weak var numberOfPlayerSeatsDropDown: DropDown!
    var selectedPlayerOption: String = ""
    @IBOutlet weak var numberOfAISeatsDropDown: DropDown!
    var selectedAIOption: String = ""
    @IBOutlet weak var AIStrategyDropDown: DropDown!
    var selectedAIStrategy: String = ""
    @IBOutlet weak var numberOfDecksDropDown: DropDown!
    var selectedDecks: String = ""
    @IBOutlet weak var audioEffectsDropDown: DropDown!
    var selectedAuidoEffect: String = ""
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        if isPremium {
            
        } else {
            numberOfPlayerSeatsDropDown.optionArray = ["1", "2"]
            //numberOfPlayerSeatsDropDown.opt
            numberOfAISeatsDropDown.optionArray = ["1", "3", "5"]
            AIStrategyDropDown.optionArray = ["Optimal Strategy"]
            numberOfDecksDropDown.optionArray = ["1", "3", "6"]
            audioEffectsDropDown.optionArray = ["None"]
        }
        
        startButton.layer.cornerRadius = startButton.frame.size.height / 6
        startButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        startButton.layer.borderWidth = 1
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    
    func validateSettings() -> Bool {
        self.selectedDecks = (numberOfDecksDropDown!).text!
        self.selectedAIOption = (numberOfAISeatsDropDown!).text!
        self.selectedPlayerOption = (numberOfPlayerSeatsDropDown!).text!
        self.selectedAIStrategy = (AIStrategyDropDown!).text!
        self.selectedAuidoEffect = (audioEffectsDropDown!).text!
        if (self.selectedAuidoEffect == "" || self.selectedAIStrategy == ""
            || self.selectedPlayerOption == "" || self.selectedAIOption == ""
            || self.selectedDecks == "") {
            return false
        }
        return true
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        if validateSettings() {
            performSegue(withIdentifier: K.Segues.startgame, sender: self)
        }
    }
    
    
    
}
