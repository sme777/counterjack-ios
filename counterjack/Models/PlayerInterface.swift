//
//  PlayerInterface.swift
//  counterjack
//
//  Created by Samson Petrosyan on 12/7/20.
//  Copyright © 2020 Samson Petrosyan. All rights reserved.
//

import Foundation

class PlayerInterface: Hashable {

    
    var id: String
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    init(id: String) {
        self.id = id
    }
    
    static func == (lhs: PlayerInterface, rhs: PlayerInterface) -> Bool {
        return lhs.id == rhs.id
    }
}
