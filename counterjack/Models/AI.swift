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
    private var currentCards: Array<Card> = []
    private var dealerCards: Array<Card> = []
    
    init(betChoice: Int) {
        self.betChoice = betChoice
    }
    
    func addCurrentCard(_ card: Card) {
        currentCards.append(card)
    }
    
    func addDealerCard(_ card: Card) {
        dealerCards.append(card)
    }
    
    func removeCard(_ card: Card) {
        let cardIndex = currentCards.firstIndex{$0.face == card.face && $0.suit == card.suit}
        if let cardPosition = cardIndex {
            currentCards.remove(at: cardPosition)
        }
    }
    
    func removeDealerCard(_ card: Card) {
        let cardIndex = dealerCards.firstIndex{$0.face == card.face && $0.suit == card.suit}
        if let cardPosition = cardIndex {
            dealerCards.remove(at: cardPosition)
        }
    }
    
    func removeAllCards() {
        currentCards.removeAll()
    }
    
    func removeAllDealerCards() {
        dealerCards.removeAll()
    }
}
