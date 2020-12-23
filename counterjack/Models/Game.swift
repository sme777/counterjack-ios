//
//  Game.swift
//  counterjack
//
//  Created by Samson Petrosyan on 11/25/20.
//  Copyright © 2020 Samson Petrosyan. All rights reserved.
//

import Foundation

class Game {
    private var seats: Int = 9
    private var takenSeats: Int!
    private var tablePositions: [Int] = []
    private var deck: Deck!
    private var cards: Array<Card>!
    private var dealer: Dealer!
    private var dealerCards = Array<Card>()
    private var ais: Array<AI>!
    private var players: Array<Player>!
    private var playerCards = [Player : Array<Card>]()
    private var aiCards = [AI :Array<Card>]()
    private var playerQueue: [PlayerInterface] = []
    //private var playersCards:
    
    init() {
        self.deck = makeDeck(1)
        //self.ais = makeAIs(1)
        self.players = makePlayers(1)
        self.cards = self.deck.getRandomDeck()
        self.dealer = Dealer()
        self.takenSeats = 1
        self.tablePositions.append(1)
        self.orderPlayer()
    }
    
    init(deckNumber: Int) {
        self.deck = makeDeck(deckNumber)
        //self.ais = makeAIs(1)
        self.players = makePlayers(1)
        self.cards = self.deck.getRandomDeck()
        self.dealer = Dealer()
        self.takenSeats = 1
        self.tablePositions.append(1)
        self.orderPlayer()
    }
    
    init(deckNumber: Int, aiNumber: Int) {
        self.deck = makeDeck(deckNumber)
        self.ais = makeAIs(aiNumber)
        self.players = makePlayers(1)
        self.cards = self.deck.getRandomDeck()
        self.dealer = Dealer()
        self.takenSeats = 1 + aiNumber
        self.tablePositions.append(2)
        self.orderPlayer()
    }
    
    init(deckNumber: Int, aiNumber: Int, playerNumber: Int) {
        self.deck = makeDeck(deckNumber)
        self.ais = makeAIs(aiNumber)
        self.players = makePlayers(playerNumber)
        self.cards = self.deck.getRandomDeck()
        self.dealer = Dealer()
        self.takenSeats = playerNumber + aiNumber
        self.tablePositions.append(2)
        self.orderPlayer()
    }
    
    init(deckNumber: Int, aiNumber: Int, playerNumber: Int, positions: Int...) {
        self.deck = makeDeck(deckNumber)
        self.ais = makeAIs(aiNumber)
        self.players = makePlayers(playerNumber)
        self.cards = self.deck.getRandomDeck()
        self.dealer = Dealer()
        self.takenSeats = playerNumber + aiNumber
        self.tablePositions = positions
        self.orderPlayer()
    }
    
    private func makeDeck(_ numberOfDecks: Int) -> Deck {
        let deck = Deck(numberOfDecks: numberOfDecks)
        return deck
    }
    //initiates a list of ais
    //TODO: need to find a way to communicate AI params
    private func makeAIs(_ numberOfAIs: Int) -> Array<AI> {
        var listOfAIs: Array<AI> = []
        var count = numberOfAIs
        while count != 0 {
            let ai = AI()
            listOfAIs.append(ai)
            aiCards[ai] = []
            count -= 1
        }
        return listOfAIs
    }
    
    //initiates a list of players
    //TODO: need to find a way to communictae between Player and User
    private func makePlayers(_ numberOfPlayers: Int) -> Array<Player> {
        var listOfPlayer: Array<Player> = []
        var count = numberOfPlayers
        while count != 0 {
            let player = Player()
            listOfPlayer.append(player)
            playerCards[player] = []
            count -= 1
        }
        return listOfPlayer
    }
    
    
    private func orderPlayer() {
        var tempPlayers = players
        var tempAIs = ais
        for i in 0..<self.takenSeats {
            if tablePositions.contains(i+1) {
                playerQueue.append(tempPlayers!.popLast()!)
            } else {
                playerQueue.append(tempAIs!.popLast()!)
                
            }
        }
        playerQueue.append(dealer)
    }
    
    public func addPlayerCard(_ card: Card, initial: Bool = false) -> Int {
        let turnPlayer = playerQueue[0]
        if turnPlayer is Player {
            let player = turnPlayer as! Player
            playerCards[player]?.append(card)
            let count = GameFunctions.count(playerCards[player]!)
            if count > 21 {
                playerQueue.remove(at: 0)
            } else if initial {
                let pl = playerQueue.remove(at: 0)
                playerQueue.append(pl)
            }
            return count
            
        } else if turnPlayer is AI {
            let ai = turnPlayer as! AI
            aiCards[ai]?.append(card)
            let count = GameFunctions.count(aiCards[ai]!)
            if count > 21 {
                playerQueue.remove(at: 0)
            } else if initial {
                let pl = playerQueue.remove(at: 0)
                playerQueue.append(pl)
            }
            return count
        } else {
            dealerCards.append(card)
            if initial {
                let pl = playerQueue.remove(at: 0)
                playerQueue.append(pl)
            }
            let count = GameFunctions.count(dealerCards)
            return count
        }
    }
    
    public func removeFromQueue() {
        playerQueue.remove(at: 0)
    }
    
    public func getDealerCards() -> Array<Card> {
        return dealerCards
    }
    
    public func getLastDealerCard() -> Card {
        return dealerCards[dealerCards.endIndex - 1]
    }
    
    public func getCurrentPlayerInterface() -> PlayerInterface {
        return playerQueue[0]
    }
    
    public func getDealer() -> PlayerInterface {
        return dealer
    }
    
    public func popTopCard() -> Card {
        return cards.remove(at: 0)
    }
    
    
    public func getDeckCount() -> Int {
        return deck.getNumberOfDecks() * 52
    }
    
    public func getPlayerOrder() -> [PlayerInterface] {
        return playerQueue
    }
    
    public func getPlayers() -> [Player] {
        return players
    }
}
