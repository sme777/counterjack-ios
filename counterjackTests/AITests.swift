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
    
    func testCorrectCountForAces() {
        let cards = [Card(suit: "H", face: "A"), Card(suit: "S", face: "A")]
        let ai = AI()
        let res = ai.count(cards)
        XCTAssertEqual(res, 12)
        
        let cards2 = [Card(suit: "H", face: "A"), Card(suit: "S", face: "A"),
                    Card(suit: "C", face: "A"), Card(suit: "D", face: "A")]
        let res2 = ai.count(cards2)
        XCTAssertEqual(res2, 14)
    }
    
    func testCorrectCountForNumbers() {
        let cards = [Card(suit: "H", face: "2"), Card(suit: "S", face: "5")]
        let ai = AI()
        let res = ai.count(cards)
        XCTAssertEqual(res, 7)
        
        let cards2 = [Card(suit: "H", face: "5"), Card(suit: "S", face: "9"),
                    Card(suit: "C", face: "7"), Card(suit: "D", face: "4")]
        let res2 = ai.count(cards2)
        XCTAssertEqual(res2, 25)
    }
    
    func testCorrectCountForFaces() {
        let cards = [Card(suit: "H", face: "J"), Card(suit: "S", face: "J")]
        let ai = AI()
        let res = ai.count(cards)
        XCTAssertEqual(res, 20)
        
        let cards2 = [Card(suit: "H", face: "Q"), Card(suit: "S", face: "K"),
                    Card(suit: "C", face: "Q"), Card(suit: "D", face: "J")]
        let res2 = ai.count(cards2)
        XCTAssertEqual(res2, 40)
    }
    
    func testCorrectCountForAll() {
        let cards = [Card(suit: "H", face: "A"), Card(suit: "S", face: "J")]
        let ai = AI()
        let res = ai.count(cards)
        XCTAssertEqual(res, 21)
        
        let cards2 = [Card(suit: "H", face: "2"), Card(suit: "S", face: "K"),
                    Card(suit: "C", face: "A"), Card(suit: "D", face: "A")]
        let res2 = ai.count(cards2)
        XCTAssertEqual(res2, 14)
    }
    
    func testCorrectSplit() {
        
    }
    
    func testIncorrectSplit() {
        
    }
    
    func testCorrectSoftMove() {
        
    }
    
    func testIncorrectSoftMove() {
        
    }
    
    func testCorrectHardMove1() {
        let card1 = Card(suit: "H", face: "10")
        let card2 = Card(suit: "S", face: "5")
        let card3 = Card(suit: "C", face: "7")
        let card4 = Card(suit: "D", face: "4")
        let ai = AI()
        ai.addCurrentCard(card1)
        ai.addCurrentCard(card2)
        ai.addDealerCard(card3)
        let action = ai.hard()
        XCTAssertEqual(action, Action.HIT)
        ai.removeDealerCard(card3)
        ai.addDealerCard(card4)
        let action2 = ai.hard()
        XCTAssertEqual(action2, Action.STAND)
    }
    
    
    func testCorrectSplitMove1() {
        let card1 = Card(suit: "H", face: "10")
        let card2 = Card(suit: "S", face: "10")
        let ai = AI()
        ai.addCurrentCard(card1)
        ai.addCurrentCard(card2)
        let action = ai.split()
        XCTAssertEqual(action, Action.NOSPLIT)
    }
    
    func testCorrectSplitMove2() {
        let card1 = Card(suit: "H", face: "A")
        let card2 = Card(suit: "S", face: "A")
        let ai = AI()
        ai.addCurrentCard(card1)
        ai.addCurrentCard(card2)
        let action = ai.split()
        XCTAssertEqual(action, Action.SPLIT)
    }
    
    func testCorrectSplitMove3() {
        let card1 = Card(suit: "H", face: "9")
        let card2 = Card(suit: "S", face: "9")
        let card3 = Card(suit: "C", face: "7")
        let ai = AI()
        ai.addCurrentCard(card1)
        ai.addCurrentCard(card2)
        ai.addDealerCard(card3)
        let action = ai.split()
        XCTAssertEqual(action, Action.NOSPLIT)
    }
    
    func testCorrectSplitMove4() {
        let card1 = Card(suit: "H", face: "4")
        let card2 = Card(suit: "S", face: "4")
        let card3 = Card(suit: "C", face: "6")
        let ai = AI(betChoice: 5000, doubleAfterSplit: false)
        ai.addCurrentCard(card1)
        ai.addCurrentCard(card2)
        ai.addDealerCard(card3)
        let action = ai.split()
        XCTAssertEqual(action, Action.NOSPLIT)
    }
    
    func testCorrectSplitMove5() {
        let card1 = Card(suit: "H", face: "4")
        let card2 = Card(suit: "S", face: "4")
        let card3 = Card(suit: "C", face: "6")
        let ai = AI(betChoice: 5000, doubleAfterSplit: true)
        ai.addCurrentCard(card1)
        ai.addCurrentCard(card2)
        ai.addDealerCard(card3)
        let action = ai.split()
        XCTAssertEqual(action, Action.SPLIT)
    }
    
    func testCorrectSplitMove6() {
        let card1 = Card(suit: "H", face: "9")
        let card2 = Card(suit: "S", face: "9")
        let card3 = Card(suit: "C", face: "A")
        let ai = AI(betChoice: 5000, doubleAfterSplit: true)
        ai.addCurrentCard(card1)
        ai.addCurrentCard(card2)
        ai.addDealerCard(card3)
        let action = ai.split()
        XCTAssertEqual(action, Action.NOSPLIT)
    }
    
    
    func testCorrectSurrenderMove() {
        
    }
    
    func testIncorrectSurrenderMove() {
        
    }
}
