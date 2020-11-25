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
        ai.addCurrentCards(card1, card2)
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
        ai.addCurrentCards(card3, card4)
        ai.removeAllCards()
        XCTAssertEqual(ai.getCurrentCards().count, 0)
        ai.removeAllDealerCards()
        XCTAssertEqual(ai.getDealerCards().count, 0)
    }
    
    func testCorrectCountForAces() {
        let cards = [Card(suit: "H", face: "A"), Card(suit: "S", face: "A")]
        let res = GameFunctions.count(cards)
        XCTAssertEqual(res, 12)
        
        let cards2 = [Card(suit: "H", face: "A"), Card(suit: "S", face: "A"),
                    Card(suit: "C", face: "A"), Card(suit: "D", face: "A")]
        let res2 = GameFunctions.count(cards2)
        XCTAssertEqual(res2, 14)
    }
    
    func testCorrectCountForNumbers() {
        let cards = [Card(suit: "H", face: "2"), Card(suit: "S", face: "5")]
        let res = GameFunctions.count(cards)
        XCTAssertEqual(res, 7)
        
        let cards2 = [Card(suit: "H", face: "5"), Card(suit: "S", face: "9"),
                    Card(suit: "C", face: "7"), Card(suit: "D", face: "4")]
        let res2 = GameFunctions.count(cards2)
        XCTAssertEqual(res2, 25)
    }
    
    func testCorrectCountForFaces() {
        let cards = [Card(suit: "H", face: "J"), Card(suit: "S", face: "J")]
        let res = GameFunctions.count(cards)
        XCTAssertEqual(res, 20)
        
        let cards2 = [Card(suit: "H", face: "Q"), Card(suit: "S", face: "K"),
                    Card(suit: "C", face: "Q"), Card(suit: "D", face: "J")]
        let res2 = GameFunctions.count(cards2)
        XCTAssertEqual(res2, 40)
    }
    
    func testCorrectCountForAll() {
        let cards = [Card(suit: "H", face: "A"), Card(suit: "S", face: "J")]
        let res = GameFunctions.count(cards)
        XCTAssertEqual(res, 21)
        
        let cards2 = [Card(suit: "H", face: "2"), Card(suit: "S", face: "K"),
                    Card(suit: "C", face: "A"), Card(suit: "D", face: "A")]
        let res2 = GameFunctions.count(cards2)
        XCTAssertEqual(res2, 14)
    }
    
    
    func testCorrectSoftMove1() {
        let card1 = Card(suit: "H", face: "A")
        let card2 = Card(suit: "S", face: "9")
        let ai = AI()
        ai.addCurrentCards(card1, card2)
        let action = ai.soft(cards: ai.getCurrentCards())
        XCTAssertEqual(action, Action.STAND)
    }
    
    func testCorrectSoftMove2() {
        let card1 = Card(suit: "H", face: "A")
        let card2 = Card(suit: "S", face: "5")
        let card3 = Card(suit: "C", face: "3")
        let ai = AI()
        ai.addCurrentCards(card1, card2)
        ai.addDealerCard(card3)
        let action = ai.soft(cards: ai.getCurrentCards())
        XCTAssertEqual(action, Action.HIT)
    }
    
    func testCorrectSoftMove3() {
        let card1 = Card(suit: "H", face: "A")
        let card2 = Card(suit: "S", face: "5")
        let card3 = Card(suit: "C", face: "5")
        let ai = AI()
        ai.addCurrentCards(card1, card2)
        ai.addDealerCard(card3)
        let action = ai.soft(cards: ai.getCurrentCards())
        XCTAssertEqual(action, Action.DOUBLE)
    }
    
    func testCorrectSoftMove4() {
        let card1 = Card(suit: "H", face: "A")
        let card2 = Card(suit: "D", face: "A")
        let card3 = Card(suit: "S", face: "5")
        let card4 = Card(suit: "C", face: "5")
        let ai = AI()
        ai.addCurrentCards(card1, card2, card3)
        ai.addDealerCard(card4)
        let action = ai.soft(cards: ai.getCurrentCards())
        XCTAssertEqual(action, Action.DOUBLE)
    }
    
    func testCorrectSoftMove5() {
        let card1 = Card(suit: "H", face: "A")
        let card2 = Card(suit: "D", face: "A")
        let card3 = Card(suit: "S", face: "5")
        let card4 = Card(suit: "C", face: "K")
        let ai = AI()
        ai.addCurrentCards(card1, card2, card3)
        ai.addDealerCard(card4)
        let action = ai.soft(cards: ai.getCurrentCards())
        XCTAssertEqual(action, Action.HIT)
    }
    
    
    func testCorrectHardMove1() {
        let card1 = Card(suit: "H", face: "10")
        let card2 = Card(suit: "S", face: "5")
        let card3 = Card(suit: "C", face: "7")
        let card4 = Card(suit: "D", face: "4")
        let ai = AI()
        ai.addCurrentCards(card1, card2)
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
        ai.addCurrentCards(card1, card2)
        let action = ai.split()
        XCTAssertEqual(action, Action.NOSPLIT)
    }
    
    func testCorrectSplitMove2() {
        let card1 = Card(suit: "H", face: "A")
        let card2 = Card(suit: "S", face: "A")
        let ai = AI()
        ai.addCurrentCards(card1, card2)
        let action = ai.split()
        XCTAssertEqual(action, Action.SPLIT)
    }
    
    func testCorrectSplitMove3() {
        let card1 = Card(suit: "H", face: "9")
        let card2 = Card(suit: "S", face: "9")
        let card3 = Card(suit: "C", face: "7")
        let ai = AI()
        ai.addCurrentCards(card1, card2)
        ai.addDealerCard(card3)
        let action = ai.split()
        XCTAssertEqual(action, Action.NOSPLIT)
    }
    
    func testCorrectSplitMove4() {
        let card1 = Card(suit: "H", face: "4")
        let card2 = Card(suit: "S", face: "4")
        let card3 = Card(suit: "C", face: "6")
        let ai = AI(betChoice: 5000, doubleAfterSplit: false)
        ai.addCurrentCards(card1, card2)
        ai.addDealerCard(card3)
        let action = ai.split()
        XCTAssertEqual(action, Action.NOSPLIT)
    }
    
    func testCorrectSplitMove5() {
        let card1 = Card(suit: "H", face: "4")
        let card2 = Card(suit: "S", face: "4")
        let card3 = Card(suit: "C", face: "6")
        let ai = AI(betChoice: 5000, doubleAfterSplit: true)
        ai.addCurrentCards(card1, card2)
        ai.addDealerCard(card3)
        let action = ai.split()
        XCTAssertEqual(action, Action.SPLIT)
    }
    
    func testCorrectSplitMove6() {
        let card1 = Card(suit: "H", face: "9")
        let card2 = Card(suit: "S", face: "9")
        let card3 = Card(suit: "C", face: "A")
        let ai = AI(betChoice: 5000, doubleAfterSplit: true)
        ai.addCurrentCards(card1, card2)
        ai.addDealerCard(card3)
        let action = ai.split()
        XCTAssertEqual(action, Action.NOSPLIT)
    }
    
    func testCorrectSurrender() {
        let card1 = Card(suit: "H", face: "9")
        let card2 = Card(suit: "S", face: "7")
        let card3 = Card(suit: "C", face: "A")
        let ai = AI()
        ai.addCurrentCards(card1, card2)
        ai.addDealerCard(card3)
        let action = ai.move()
        XCTAssertEqual(action, Action.SURRENDER)
    }
    
    func testMove1() {
        let card1 = Card(suit: "H", face: "9")
        let card2 = Card(suit: "S", face: "7")
        let card3 = Card(suit: "C", face: "9")
        let card4 = Card(suit: "C", face: "A")
        let ai = AI()
        ai.addCurrentCard(card1)
        ai.addCurrentCard(card2)
        ai.addCurrentCard(card3)
        ai.addDealerCard(card4)
        let action = ai.move()
        XCTAssertEqual(action, Action.BUST)
    }
    
    func testMove2() {
        let card1 = Card(suit: "H", face: "4")
        let card2 = Card(suit: "S", face: "4")
        let card3 = Card(suit: "C", face: "4")
        let card4 = Card(suit: "C", face: "6")
        let ai = AI()
        ai.addCurrentCards(card1, card2, card3)
        ai.addDealerCard(card4)
        let action = ai.move()
        XCTAssertEqual(action, Action.STAND)
    }
    
    func testMove3() {
        let card1 = Card(suit: "H", face: "7")
        let card2 = Card(suit: "S", face: "A")
        let card3 = Card(suit: "C", face: "10")
        let card4 = Card(suit: "D", face: "3")
        let card5 = Card(suit: "C", face: "4")
        let ai = AI()
        ai.addCurrentCards(card1, card2, card3, card4)
        ai.addDealerCard(card5)
        let action = ai.move()
        XCTAssertEqual(action, Action.BLACKJACK)
    }
    
    func testMove4() {
        let card1 = Card(suit: "H", face: "A")
        let card2 = Card(suit: "S", face: "3")
        let card3 = Card(suit: "C", face: "2")
        let card4 = Card(suit: "C", face: "9")
        let ai = AI()
        ai.addCurrentCards(card1, card2, card3)
        ai.addDealerCard(card4)
        let action = ai.move()
        XCTAssertEqual(action, Action.HIT)
    }
    
    func testMove5() {
        let card1 = Card(suit: "H", face: "2")
        let card2 = Card(suit: "S", face: "3")
        let card3 = Card(suit: "C", face: "5")
        let card4 = Card(suit: "C", face: "7")
        let card5 = Card(suit: "D", face: "3")
        let card6 = Card(suit: "D", face: "Q")
        let ai = AI()
        ai.addCurrentCards(card1, card2, card3, card4, card5)
        ai.addDealerCard(card6)
        let action = ai.move()
        XCTAssertEqual(action, Action.STAND)
    }
    
    
}
