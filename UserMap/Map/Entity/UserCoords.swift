//
//  UserCoords.swift
//  UserMap
//
//  Created by Max Rybak on 11/17/18.
//  Copyright © 2018 Max Rybak. All rights reserved.
//

struct UserCoords {
    let username: String
    let lat: Double
    let lon: Double
    
    init(username: String, lat: Double, lon: Double) {
        self.username = username
        self.lat = lat
        self.lon = lon
    }
}
