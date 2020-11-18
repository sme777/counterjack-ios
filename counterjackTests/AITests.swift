//
//  AITests.swift
//  counterjackTests
//
//  Created by Samson Petrosyan on 11/18/20.
//  Copyright © 2020 Samson Petrosyan. All rights reserved.
//

import Foundation
import XCTest
@testable import counterjack

class AITests: XCTestCase {
    
    
    func testMakeDefaultAI() {
        let ai = AI()
        XCTAssertEqual(ai.getBetChoice(), 1)
        XCTAssertEqual(ai.getBankroll(), 5000)
        XCTAssertEqual(ai.getDoubleAfterSplit(), true)
    }
    
    func testCustomBetChoiceAI() {
        let ai = AI(betChoice: 2)
        XCTAssertEqual(ai.getBetChoice(), 2)
        XCTAssertEqual(ai.getBankroll(), 5000)
        XCTAssertEqual(ai.getDoubleAfterSplit(), true)
    }
    
    func testCustomBetChoiceAndBankrollAI() {
        let ai = AI(betChoice: 3, bankroll: 2500)
        XCTAssertEqual(ai.getBetChoice(), 3)
        XCTAssertEqual(ai.getBankroll(), 2500)
        XCTAssertEqual(ai.getDoubleAfterSplit(), true)
    }
    
    
    func testCustomBetChoiceAndSplitAI() {
        let ai = AI(betChoice: 1, doubleAfterSplit: false)
        XCTAssertEqual(ai.getBetChoice(), 1)
        XCTAssertEqual(ai.getBankroll(), 5000)
        XCTAssertEqual(ai.getDoubleAfterSplit(), false)
    }
    
    func testCustomBetChoiceAndBankrollAndSplitAI() {
        let ai = AI(betChoice: 10, doubleAfterSplit: true, bankroll: 10000)
        XCTAssertEqual(ai.getBetChoice(), 10)
        XCTAssertEqual(ai.getBankroll(), 10000)
        XCTAssertEqual(ai.getDoubleAfterSplit(), true)
    }
    
    
    func testAddingCard() {
        let ai = AI()
        let card1 = Card(suit: "H", face: "A")
        let card2 = Card(suit: "S", face: "2")
        ai.addCurrentCard(card1)
        ai.addDealerCard(card2)
        XCTAssertEqual(ai.getCurrentCards().first, card1)
        XCTAssertEqual(ai.getDealerCards().first, card2)
        XCTAssertEqual(ai.getCurrentCards().count, 1)
        XCTAssertEqual(ai.getDealerCards().count, 1)
    }
    
    func testRemovingAICards() {
        let ai = AI()
        let card1 = Card(suit: "H", face: "A")
        let card2 = Card(suit: "S", face: "2")
        ai.addCurrentCard(card1)
        ai.addCurrentCard(card2)
        XCTAssertEqual(ai.getCurrentCards()[0], card1)
        XCTAssertEqual(ai.getCurrentCards()[1], card2)
        ai.removeCard(card1)
        XCTAssertEqual(ai.getCurrentCards().count, 1)
        XCTAssertEqual(ai.getCurrentCards()[0], card2)
        ai.removeCard(card2)
        XCTAssertEqual(ai.getCurrentCards().count, 0)
    }
    
    func testRemovingDealerCards() {
        let ai = AI()
        let card1 = Card(suit: "C", face: "A")
        let card2 = Card(suit: "D", face: "9")
        ai.addDealerCard(card1)
        ai.addDealerCard(card2)
        XCTAssertEqual(ai.getDealerCards()[0], card1)
        XCTAssertEqual(ai.getDealerCards()[1], card2)
        ai.removeDealerCard(card1)
        XCTAssertEqual(ai.getDealerCards().count, 1)
        XCTAssertEqual(ai.getDealerCards()[0], card2)
        ai.removeDealerCard(card2)
        XCTAssertEqual(ai.getDealerCards().count, 0)
    }
    
    func testRemovingAllCards() {
        let ai = AI()
        let card1 = Card(suit: "C", face: "A")
        let card2 = Card(suit: "D", face: "9")
        ai.addDealerCard(card1)
        ai.addDealerCard(card2)
        let card3 = Card(suit: "C", face: "A")
        let card4 = Card(suit: "D", face: "9")
        ai.addCurrentCard(card3)
        ai.addCurrentCard(card4)
        ai.removeAllCards()
        XCTAssertEqual(ai.getCurrentCards().count, 0)
        ai.removeAllDealerCards()
        XCTAssertEqual(ai.getDealerCards().count, 0)
    }
    
    func testCorrectSplit() {
        
    }
    
    func testIncorrectSplit() {
        
    }
    
    func testCorrectSoftMove() {
        
    }
    
    func testIncorrectSoftMove() {
        
    }
    
    func testCorrectHardMove() {
        
    }
    
    func testIncorrectHardMove() {
        
    }
    
    func testCorrectSurrenderMove() {
        
    }
    
    func testIncorrectSurrenderMove() {
        
    }
}
