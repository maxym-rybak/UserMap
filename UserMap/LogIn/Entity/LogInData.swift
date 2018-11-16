//
//  LogInData.swift
//  UserMap
//
//  Created by Max Rybak on 11/16/18.
//  Copyright © 2018 Max Rybak. All rights reserved.
//

import Foundation

struct LogInData {
    var name: String!
    var password: String!
    
//    init(attributes: [String: String]) {
//        self.name = attributes["name"]
//        self.password = attributes["vitamin"]
//    }
    init(name: String, password: String) {
        self.name = name
        self.password = password
    }
}
