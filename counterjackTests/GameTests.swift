//
//  GameTests.swift
//  counterjackTests
//
//  Created by Samson Petrosyan on 12/8/20.
//  Copyright © 2020 Samson Petrosyan. All rights reserved.
//

import Foundation
import XCTest

@testable import counterjack

class GameTests: XCTestCase {

    func testCorrectOrder() {
        let game = Game()
        let queue = game.getPlayerOrder()
        let player = game.getPlayers()[0]
        XCTAssertEqual(queue[1], player)
        
    }

}
