//
//  Game.swift
//  counterjack
//
//  Created by Samson Petrosyan on 11/25/20.
//  Copyright © 2020 Samson Petrosyan. All rights reserved.
//

import Foundation

class Game {
    private var deck: Deck!
    private var ais: Array<AI>!
    private var players: Array<Player>!
    
    init() {
        self.deck = makeDeck(1)
        self.ais = makeAIs(1)
        self.players = makePlayers(1)
    }
    
    init(deckNumber: Int) {
        self.deck = makeDeck(deckNumber)
        self.ais = makeAIs(1)
        self.players = makePlayers(1)
    }
    
    init(deckNumber: Int, aiNumber: Int) {
        self.deck = makeDeck(deckNumber)
        self.ais = makeAIs(aiNumber)
        self.players = makePlayers(1)
    }
    
    init(deckNumber: Int, aiNumber: Int, playerNumber: Int) {
        self.deck = makeDeck(deckNumber)
        self.ais = makeAIs(aiNumber)
        self.players = makePlayers(playerNumber)
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
            count -= 1
        }
        return listOfPlayer
    }
}