//
//  GameFunctions.swift
//  counterjack
//
//  Created by Samson Petrosyan on 11/25/20.
//  Copyright © 2020 Samson Petrosyan. All rights reserved.
//

import Foundation


class GameFunctions {
        public static func count(_ cards: Array<Card>, shouldCountAces: Bool=true) -> Int {
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
}
