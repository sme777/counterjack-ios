//
//  Card.swift
//  counterjack
//
//  Created by Samson Petrosyan on 11/16/20.
//  Copyright © 2020 Samson Petrosyan. All rights reserved.
//

import Foundation

struct Card: Equatable {
    var suit: String
    var face: String
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.suit == rhs.suit && lhs.face == rhs.face
    }
}
