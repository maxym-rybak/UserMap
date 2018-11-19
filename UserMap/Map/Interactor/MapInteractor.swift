//
//  MapInteractor.swift
//  UserMap
//
//  Created by Max Rybak on 11/16/18.
//  Copyright © 2018 Max Rybak. All rights reserved.
//

import FirebaseDatabase
import FirebaseAuth

class MapInteractor: MapInputInteractorProtocol {
    
    weak var presenter: MapOutputInteractorProtocol?
    
    var ref: DatabaseReference!
    var locationsFromFirebase: [DataSnapshot] = []
    var allUsersCoords: [UserCoords] = []
    
    init() {
        ref = Database.database().reference()
        addObserver()
    }
    
    func addObserver (){
        ref.child("UserLocation").observe(.childAdded) {
            (snapshot) in
            self.locationsFromFirebase.append(snapshot)
            for elem in self.locationsFromFirebase {
                if let userDictionary = elem.value as? [String:AnyObject] {
                    if let email = userDictionary["email"] as? String
                        , let lat = userDictionary["lat"] as? Double
                        , let lon = userDictionary["lon"] as? Double {
                        let newUser = UserCoords(username: email, lat: lat, lon: lon)
                        if self.allUsersCoords.contains(where: { $0.username == newUser.username }) == false {
                            self.allUsersCoords.append(newUser)
                        }
                    }
                }
            }
            self.presenter?.createAnnotations(locationsFromFirebase: &self.allUsersCoords)
        }
    }
    
    func addUserToFirebase(userLocation: UserCoords) {
        if let email = Auth.auth().currentUser?.email , let userID = Auth.auth().currentUser?.uid {
            let userDataDictionary : [String:Any] = ["email" : email, "lat" : userLocation.lat, "lon" : userLocation.lon]
            ref.child("UserLocation").child(userID).setValue(userDataDictionary)
        }
    }
    
    func updateMap() {
        presenter?.createAnnotations(locationsFromFirebase: &allUsersCoords)
    }
    
}
