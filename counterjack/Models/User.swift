//
//  User.swift
//  counterjack
//
//  Created by Samson Petrosyan on 11/23/20.
//  Copyright © 2020 Samson Petrosyan. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var id: String = ""
    @objc dynamic var date: Double = 0
    @objc dynamic var email: String = ""
    @objc dynamic var karma: Int = 0
    let friends = List<User>()
    
//    init(name: String, id: String) {
//        self.name = name
//        self.id = id
//    }
//
//    required init() {
//        //fatalError("init() has not been implemented")
//    }
//
}
