//
//  AI.swift
//  counterjack
//
//  Created by Samson Petrosyan on 11/16/20.
//  Copyright © 2020 Samson Petrosyan. All rights reserved.
//

import Foundation


class AI {
    
    private var betChoice: Int
    private var doubleAfterSplit: Bool
    private var bankroll: Double
    private var currentCards: Array<Card> = []
    private var dealerCards: Array<Card> = []
    
    //MARK: - AI initializers

    init() {
        self.betChoice = 1
        self.doubleAfterSplit = true
        self.bankroll = 5000
    }
    
    init(betChoice: Int) {
        self.betChoice = betChoice
        self.doubleAfterSplit = true
        self.bankroll = 5000
    }
    
    init(betChoice: Int, doubleAfterSplit: Bool) {
        self.betChoice = betChoice
        self.bankroll = 5000
        self.doubleAfterSplit = doubleAfterSplit
    }
    
    
    init(betChoice: Int, bankroll: Double) {
        self.betChoice = betChoice
        self.bankroll = bankroll
        self.doubleAfterSplit = true
    }
    
    init(betChoice: Int, doubleAfterSplit: Bool, bankroll: Double) {
        self.betChoice = betChoice
        self.bankroll = bankroll
        self.doubleAfterSplit = doubleAfterSplit
    }
    
    public func addCurrentCard(_ card: Card) {
        currentCards.append(card)
    }
    
    public func addDealerCard(_ card: Card) {
        dealerCards.append(card)
    }
    
    public func removeCard(_ card: Card) {
        let cardIndex = currentCards.firstIndex{$0.face == card.face && $0.suit == card.suit}
        if let cardPosition = cardIndex {
            currentCards.remove(at: cardPosition)
        }
    }
    
    public func removeDealerCard(_ card: Card) {
        let cardIndex = dealerCards.firstIndex{$0.face == card.face && $0.suit == card.suit}
        if let cardPosition = cardIndex {
            dealerCards.remove(at: cardPosition)
        }
    }
    
    public func removeAllCards() {
        currentCards.removeAll()
    }
    
    public func removeAllDealerCards() {
        dealerCards.removeAll()
    }
    
    public func move() -> String? {
        if !isValid() {
            return nil
        } else if currentCards[0].face == currentCards[1].face {
            return split()
        } else if isSoft() {
            if isSurrender() {
                return "surrender"
            } else {
                return soft()
            }
        } else {
            if isSurrender() {
                return "surrender"
            } else {
                return hard()
            }
        }
    }
    
    
    private func isValid() -> Bool {
        return currentCards.count == 2 && dealerCards.count == 1
    }
    
    //check if the sum exceeds 21 for Ace
    private func isSoft() -> Bool {
        for i in 0..<currentCards.count {
            if (currentCards[i].face == "A") {
                return true
            }
        }
        return false
    }
    
    private func isSurrender() -> Bool {
        let sum = count(currentCards)
        if sum == 16 && !isSoft() && inRange(from: "9", to: "A") {
            return true
        } else if sum == 15  && !isSoft() && inRange(from: "10", to: "A") {
            return true
        } else {
            return false
        }
    }
    // TODO: splits cards
    private func split() -> String {
        return ""
    }
    // TODO: moves on soft cards
    private func soft() -> String {
        return ""
    }
    
    // TODO: moves on hard cards
    private func hard() -> String {
        return ""
    }
    // TODO: counts hand cards
    private func count(_ cards: Array<Card>) -> Int {
        return 0
    }
    
    // TODO: check is any of the cards in range is Dealers card
    private func inRange(from: String, to: String) -> Bool {
        return false
    }
    // MARK: - Getter methods
    
    public func getCurrentCards() -> Array<Card> {
        return self.currentCards
    }
    
    public func getDealerCards() -> Array<Card> {
        return self.dealerCards
    }
    
    public func getBankroll() -> Double {
        return self.bankroll
    }
    
    public func getBetChoice() -> Int {
        return self.betChoice
    }
    
    public func getDoubleAfterSplit() -> Bool {
        return self.doubleAfterSplit
    }
    
}
