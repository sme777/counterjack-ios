//
//  DealerTests.swift
//  counterjackTests
//
//  Created by Samson Petrosyan on 11/18/20.
//  Copyright © 2020 Samson Petrosyan. All rights reserved.
//

import Foundation
import XCTest
@testable import counterjack

class DealerTests: XCTestCase {
    
    func testAddingCard() {
        let card1 = Card(suit: "D", face: "K")
        let card2 = Card(suit: "C", face: "2")
        let dealer = Dealer()
        dealer.addCard(card1)
        dealer.addCard(card2)
        XCTAssertEqual(dealer.getCards().count, 2)
        dealer.removeCard(card1)
        XCTAssertEqual(dealer.getCards().count, 1)
    }
    
    func testRemovingCard() {
        let card1 = Card(suit: "D", face: "K")
        let card2 = Card(suit: "C", face: "2")
        let dealer = Dealer()
        dealer.addCard(card1)
        dealer.addCard(card2)
        XCTAssertEqual(dealer.getCards().count, 2)
        dealer.removeCard(card1)
        XCTAssertEqual(dealer.getCards().count, 1)
        dealer.removeCard(card2)
        XCTAssertEqual(dealer.getCards().count, 0)
    }
    
    func testRemovingAllCards() {
        let card1 = Card(suit: "D", face: "K")
        let card2 = Card(suit: "C", face: "2")
        let dealer = Dealer()
        dealer.addCard(card1)
        dealer.addCard(card2)
        XCTAssertEqual(dealer.getCards().count, 2)
        dealer.removeAllCards()
        XCTAssertEqual(dealer.getCards().count, 0)
    }
    
    func testMove1() {
        let card1 = Card(suit: "D", face: "7")
        let card2 = Card(suit: "C", face: "2")
        let dealer = Dealer()
        dealer.addCards(card1, card2)
        let action = dealer.move()
        XCTAssertEqual(action, Action.HIT)
    }
    
    func testMove2() {
        let card1 = Card(suit: "D", face: "K")
        let card2 = Card(suit: "C", face: "2")
        let card3 = Card(suit: "H", face: "7")
        let card4 = Card(suit: "S", face: "J")
        let dealer = Dealer()
        dealer.addCards(card1, card2, card3, card4)
        let action = dealer.move()
        XCTAssertEqual(action, Action.BUST)
    }
    
    func testMove3() {
        let card1 = Card(suit: "D", face: "K")
        let card2 = Card(suit: "C", face: "A")
        let dealer = Dealer()
        dealer.addCards(card1, card2)
        let action = dealer.move()
        XCTAssertEqual(action, Action.BLACKJACK)
    }
    
    func testMove4() {
        let card1 = Card(suit: "D", face: "K")
        let card2 = Card(suit: "C", face: "2")
        let card3 = Card(suit: "H", face: "7")
        let dealer = Dealer()
        dealer.addCards(card1, card2, card3)
        let action = dealer.move()
        XCTAssertEqual(action, Action.STAND)
    }
}
