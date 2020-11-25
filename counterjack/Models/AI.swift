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
    private var cardFaces: Array<String> = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
    private var currentCards: Array<Card> = []
    private var dealerCards: Array<Card> = []
    
    //MARK: - AI initializers

    init() {
        self.betChoice = 1
        self.doubleAfterSplit = true
        self.bankroll = 5000
    }
    
    init(doubleAfterSplit: Bool) {
        self.betChoice = 1
        self.doubleAfterSplit = doubleAfterSplit
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
    
    public func move() -> Action? {
        if !isValid() {
            return nil
        } else if faceValue(currentCards[0].face) == faceValue(currentCards[1].face) {
            //return split()
            if let willSplit = split() {
                if willSplit == Action.NOSPLIT {
                    return hard()
                } else {
                    return willSplit
                }
            } else {
                //what happens when split() returns nil
                return Action.STAND
            }
        } else if isSoft() {
            if isSurrender() {
                return Action.SURRENDER
            } else {
                
                return soft(cards: currentCards)
            }
        } else {
            if isSurrender() {
                return Action.SURRENDER
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
    
    public func split() -> Action? {
        let card = currentCards[0]
        switch card.face {
        case "A",
             "8":
            return Action.SPLIT
        case "K",
             "Q",
             "J",
             "10",
             "5":
            return Action.NOSPLIT
        case "9":
            if inRange(from: "10", to: "A") || inRange(from: "7", to: "7") {
                return Action.NOSPLIT
            } else {
                return Action.SPLIT
            }
        case "7":
            if inRange(from: "8", to: "A") {
                return Action.NOSPLIT
            } else {
                return Action.SPLIT
            }
        case "6":
            if self.doubleAfterSplit && inRange(from: "2", to: "2") {
                return Action.SPLIT
            } else if inRange(from: "7", to: "A") {
                return Action.NOSPLIT
            } else {
                return Action.SPLIT
            }
        case "4":
            if self.doubleAfterSplit {
                if inRange(from: "5", to: "6") {
                    return Action.SPLIT
                } else {
                    return Action.NOSPLIT
                }
            } else {
                return Action.NOSPLIT
            }
        case "3":
            if doubleAfterSplit && inRange(from: "2", to: "3") {
                return Action.SPLIT
            } else if inRange(from: "4", to: "7") {
                return Action.SPLIT
            } else {
                return Action.NOSPLIT
            }
        case "2":
            if doubleAfterSplit && inRange(from: "2", to: "3") {
                return Action.SPLIT
            } else if inRange(from: "4", to: "7") {
                return Action.SPLIT
            } else {
                return Action.NOSPLIT
            }
        default:
             return nil
        }
    }
    // TODO: moves on soft cards
    public func soft(cards: Array<Card>) -> Action {
        
        if cards.count == 2 {
            switch fetchNotAce() {
            case "9":
                return Action.STAND
            case "8":
                if inRange(from: "6", to: "6") {
                    return Action.DOUBLE
                } else {
                    return Action.STAND
                }
            case "7":
                if inRange(from: "9", to: "A") {
                    return Action.HIT
                } else if inRange(from: "7", to: "8") {
                    return Action.STAND
                } else {
                    return Action.STAND
                }
            case "6":
                if inRange(from: "3", to: "6") {
                    return Action.DOUBLE
                } else {
                    return Action.HIT
                }
            case "5":
                if inRange(from: "4", to: "6") {
                    return Action.DOUBLE
                } else {
                    return Action.HIT
                }
            case "4":
                if inRange(from: "4", to: "6") {
                    return Action.DOUBLE
                } else {
                    return Action.HIT
                }
            case "3":
                if inRange(from: "5", to: "6") {
                    return Action.DOUBLE
                } else {
                    return Action.HIT
                }
            case "2":
                if inRange(from: "5", to: "6") {
                    return Action.DOUBLE
                } else {
                    return Action.HIT
                }
            //case "":
            default:
                return Action.BLACKJACK
            }
        } else {
            let aces = countAces()
            var counts = count(currentCards, shouldCountAces: false)
            
            if counts + (10 + aces) > 21 {
                counts += aces
                return hard()
            } else {
                var tempCards: Array<Card> = []
                tempCards.append(Card(suit: "M", face: "A"))
                tempCards.append(Card(suit: "M", face: String(counts + 1)))
                return soft(cards: tempCards)
                //makes a recursive call to soft
            }
        }
    }
    

    public func hard() -> Action {
        
        let value = count(currentCards)
        
        if value == 17 {
            return Action.STAND
        } else if isValue(value: value, from: 13, to: 16) {
            if inRange(from: "2", to: "6") {
                return Action.STAND
            } else {
                return Action.HIT
            }
        } else if value == 12 {
            if inRange(from: "4", to: "6") {
                return Action.STAND
            } else {
                return Action.HIT
            }
        } else if value == 11 {
            return Action.DOUBLE
        } else if value == 10 {
            if inRange(from: "10", to: "A") {
                return Action.HIT
            } else {
                return Action.DOUBLE
            }
        } else if value == 9 {
            if inRange(from: "3", to: "6") {
                return Action.DOUBLE
            } else {
                return Action.HIT
            }
        } else if value == 8 {
            return Action.HIT
        } else if value > 17 {
            if value == 21 {
                return Action.BLACKJACK
            } else if value > 21 {
                return Action.BUST
            } else {
                return Action.STAND
            }
        } else {
            return Action.HIT
        }
    }

    public func count(_ cards: Array<Card>, shouldCountAces: Bool=true) -> Int {
        var sum = 0
        var aces: Array<Card> = []
        for i in 0..<cards.count {
            if cards[i].face == "J" || cards[i].face == "Q" || cards[i].face == "K" {
                sum += 10
            } else if cards[i].face != "A" {
                sum += Int(cards[i].face) ?? 0
            } else {
                aces.append(cards[i])
            }
        }
        if shouldCountAces {
            for _ in 0..<aces.count {
                if sum + 11 > 21 {
                    sum += 1
                } else if sum + 11 <= 21 && aces.count == 1 {
                    sum += 11
                } else if sum + 11 <= 21 && aces.count != 1 {
                    if sum + 10 + aces.count > 21 {
                        sum += 1
                    } else {
                        sum += 11
                    }
                } else {
                    sum += 1
                }
            }
        }
        
        return sum
    }
    
    private func countAces() -> Int {
        var aces = 0
        for i in 0..<currentCards.count {
            if currentCards[i].face == "A" {
                aces += 1
            }
        }
        return aces
    }
    
    private func faceValue(_ value: String) -> Int {
        //let index: Int = cardFaces.firstIndex{$0 == value}!
        var parsed = Int(value) ?? 0
        if value == "A" && parsed == 0 {
            parsed = 11
        } else if parsed == 0 {
            parsed = 10
        }
        return parsed
    }
    
    private func fetchNotAce() -> String {
        var fetchedFace = ""
        for i in 0..<currentCards.count {
            if currentCards[i].face == "A" {
                continue
            } else {
                fetchedFace = currentCards[i].face
            }
        }
        return fetchedFace
    }
    
    private func isValue(value: Int, from: Int, to: Int) -> Bool {
        for i in from...to {
            if i == value {
                return true
            }
        }
        return false
    }
    

    private func inRange(from: String, to: String) -> Bool {
        let start: Int = cardFaces.firstIndex{$0 == from}!
        let end: Int = cardFaces.firstIndex{$0 == to}!
        for i in start...end {
            if cardFaces[i] == dealerCards[0].face {
                return true
            }
        }
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
