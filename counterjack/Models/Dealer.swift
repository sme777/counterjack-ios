//
//  Dealer.swift
//  counterjack
//
//  Created by Samson Petrosyan on 11/17/20.
//  Copyright © 2020 Samson Petrosyan. All rights reserved.
//

import Foundation


class Dealer {
    private var currentCards: Array<Card> = []
    private var bankroll: Float? = nil
    
    
    init() {
        bankroll = 50000
    }
    
    init(bankroll: Float) {
        self.bankroll = bankroll
    }
    
    public func move() -> Action {
        let handSum = GameFunctions.count(currentCards)
        
        if handSum < 17 {
            return Action.HIT
        } else if handSum > 21 {
            return Action.BUST
        } else if handSum == 21 {
            return Action.BLACKJACK
        } else {
            return Action.STAND
        }
    }
    
    
    
    public func addCard(_ card: Card) {
        currentCards.append(card)
    }
    
    public func addCards(_ cards: Card...) -> () {
        for card in cards {
            currentCards.append(card)
        }
    }
    
    public func removeCard(_ card: Card) {
        let cardIndex = currentCards.firstIndex{$0.face == card.face && $0.suit == card.suit}
        if let cardPosition = cardIndex {
            currentCards.remove(at: cardPosition)
        }
    }
    
    public func removeAllCards() {
        currentCards.removeAll()
    }
    
    public func getCards() -> Array<Card> {
        return currentCards
    }
    
}
