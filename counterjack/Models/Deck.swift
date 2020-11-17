//
//  Deck.swift
//  counterjack
//
//  Created by Samson Petrosyan on 11/18/20.
//  Copyright © 2020 Samson Petrosyan. All rights reserved.
//

import Foundation


class Deck {
    private var numberOfDecks: Int
    private var suits: Array<String> = ["D", "S", "C", "H"]
    private var faces: Array<String> = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
    private var organizedDeck: Array<Card> = []
    private var randomDeck: Array<Card> = []
    
    init() {
        self.numberOfDecks = 1
    }
    
    init(numberOfDecks: Int) {
        self.numberOfDecks = numberOfDecks
    }
    
    private func generateOrganizedDeck() {
        for _ in 1...numberOfDecks {
            for suit in 0..<suits.count {
                for face in 0..<faces.count {
                    let card = Card(suit: suits[suit], face: faces[face])
                    organizedDeck.append(card)
                }
            }
        }
    }
    
    private func generateRandomDeck() {
        if organizedDeck.count == 0 {
            generateOrganizedDeck()
        }
        
        var count = 52 * numberOfDecks
        var copyDeck = organizedDeck
        while count > 0 {
            let n = Int.random(in: 0..<count)
            randomDeck.append(copyDeck[n])
            copyDeck.remove(at: n)
            count -= 1
        }
    }
    
    public func getRandomDeck() -> Array<Card> {
        generateRandomDeck()
        return randomDeck
    }
    
    public func getOrganizedDeck() -> Array<Card> {
        generateOrganizedDeck()
        return organizedDeck
    }
    
    public func getNumberOfDecks() -> Int {
        return numberOfDecks
    }
}
