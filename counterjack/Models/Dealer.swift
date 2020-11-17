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
    
    init(bankroll: Float) {
        self.bankroll = bankroll
    }
    
    func addCard(_ card: Card) {
        currentCards.append(card)
    }
    
    func removeCard(_ card: Card) {
        let cardIndex = currentCards.firstIndex{$0.face == card.face && $0.suit == card.suit}
        if let cardPosition = cardIndex {
            currentCards.remove(at: cardPosition)
        }
    }
    
    func removeAllCards() {
        currentCards.removeAll()
    }
    
}
