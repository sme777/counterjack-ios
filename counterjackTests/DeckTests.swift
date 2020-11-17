//
//  DeckTests.swift
//  counterjackTests
//
//  Created by Samson Petrosyan on 11/18/20.
//  Copyright © 2020 Samson Petrosyan. All rights reserved.
//

import Foundation
import XCTest
@testable import counterjack

class DeckTests: XCTestCase {
    
    
    func testValidDefaultDeckSize() {
        let deck = Deck()
        XCTAssertEqual(deck.getNumberOfDecks(), 1)
    }
    
    func testInvalidDefaultDeckSize() {
        let deck = Deck(numberOfDecks: 2)
        XCTAssertNotEqual(deck.getNumberOfDecks(), 1)
    }
    
    func testValidCustomDeckSize() {
        let deck = Deck(numberOfDecks: 10)
        XCTAssertEqual(deck.getNumberOfDecks(), 10)
    }
    
    func testInvalidCustomDeckSize() {
        let deck = Deck()
        XCTAssertNotEqual(deck.getNumberOfDecks(), 3)
    }
    
    func testValidSingleOrganizedDeck() {
        let deck = Deck()
        let organizedDeck = deck.getOrganizedDeck()
        let firstCard = organizedDeck[0]
        let lastCard = organizedDeck[51]
        XCTAssertEqual(organizedDeck.count, 52)
        XCTAssertEqual(firstCard.face, "A")
        XCTAssertEqual(firstCard.suit, "D")
        XCTAssertEqual(lastCard.face, "K")
        XCTAssertEqual(lastCard.suit, "H")
    }

    
    func testValidMultipleOrganizedDeck() {
        let deck = Deck(numberOfDecks: 2)
        let organizedDeck = deck.getOrganizedDeck()
        let firstDeck1Card = organizedDeck[0]
        let lastDeck1Card = organizedDeck[51]
        let firstDeck2Card = organizedDeck[52]
        let lastDeck2Card = organizedDeck[103]
        XCTAssertEqual(organizedDeck.count, 104)
        XCTAssertEqual(firstDeck1Card.face, "A")
        XCTAssertEqual(firstDeck1Card.suit, "D")
        XCTAssertEqual(lastDeck1Card.face, "K")
        XCTAssertEqual(lastDeck1Card.suit, "H")
        XCTAssertEqual(firstDeck2Card.face, "A")
        XCTAssertEqual(firstDeck2Card.suit, "D")
        XCTAssertEqual(lastDeck2Card.face, "K")
        XCTAssertEqual(lastDeck2Card.suit, "H")
    }
    
    
    func testValidSingleRandomDeck() {
        let deck = Deck()
        let organizedDeck = deck.getRandomDeck()
        let firstCard = organizedDeck[0]
        let lastCard = organizedDeck[51]
        XCTAssertEqual(organizedDeck.count, 52)
        XCTAssertNotEqual(firstCard.face, "A")
        XCTAssertNotEqual(firstCard.suit, "D")
        XCTAssertNotEqual(lastCard.face, "K")
        XCTAssertNotEqual(lastCard.suit, "H")
    }
    
    
    func testValidMultipleRandomDeck() {
        let deck = Deck(numberOfDecks: 10)
        let organizedDeck = deck.getRandomDeck()
        let firstDeck1Card = organizedDeck[0]
        let lastDeck1Card = organizedDeck[51]
        let firstDeck10Card = organizedDeck[468]
        let lastDeck10Card = organizedDeck[519]
        
        
        let first = Card(suit: "D", face: "A")
        let last = Card(suit: "H", face: "K")
        
        XCTAssertEqual(organizedDeck.count, 520)
        XCTAssertNotEqual(firstDeck1Card, first)
        XCTAssertNotEqual(lastDeck1Card, last)
        XCTAssertNotEqual(firstDeck10Card, first)
        XCTAssertNotEqual(lastDeck10Card, last)

    }
    
}
