//
//  LogInData.swift
//  UserMap
//
//  Created by Max Rybak on 11/16/18.
//  Copyright © 2018 Max Rybak. All rights reserved.
//

struct EnteredUserData {
    let username: String!
    let password: String!
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
