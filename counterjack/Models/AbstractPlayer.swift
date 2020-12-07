//
//  AbstractPlayer.swift
//  counterjack
//
//  Created by Samson Petrosyan on 12/7/20.
//  Copyright © 2020 Samson Petrosyan. All rights reserved.
//

import Foundation

class AbstractPlayer: Hashable {
    static func == (lhs: AbstractPlayer, rhs: AbstractPlayer) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    
}
