//
//  Player.swift
//  counterjack
//
//  Created by Samson Petrosyan on 11/16/20.
//  Copyright © 2020 Samson Petrosyan. All rights reserved.
//

import Foundation


class Player: PlayerInterface {
    
    
    //private var id: String!
    private var firstName: String
    private var lastName: String
    private var email: String
    private var profilePicture: String
    private var hours: Float
    private var totalEarnings: Float
    private var rating: Float?
    
    init() {
        
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.profilePicture = ""
        self.hours = 0
        self.totalEarnings = 0
        //self.id = createNewID(0)
        self.rating = nil
        super.init(id: GameFunctions.createNewID(10))
    }
    
    init(firstName: String, lastName: String, email: String, profilePicture: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.profilePicture = profilePicture
        self.hours = 0
        self.totalEarnings = 0
        //self.id = createNewID(20)
        self.rating = nil
        super.init(id: GameFunctions.createNewID(10))
    }
    

    
}


