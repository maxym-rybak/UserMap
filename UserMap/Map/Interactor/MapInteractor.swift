//
//  MapInteractor.swift
//  UserMap
//
//  Created by Max Rybak on 11/16/18.
//  Copyright © 2018 Max Rybak. All rights reserved.
//

import FirebaseDatabase
import FirebaseAuth
import MapKit

class MapInteractor: MapInputInteractorProtocol {
    
    weak var presenter: MapOutputInteractorProtocol?
    
    var ref: DatabaseReference!
    var locationsFromFirebase: [DataSnapshot] = []
    
    init() {
        ref = Database.database().reference()
        addObserver()
    }
    
    func addObserver (){
        ref.child("UserLocation").observe(.childAdded) {
            (snapshot) in
            self.locationsFromFirebase.append(snapshot)
            self.presenter?.createAnnotations(locationsFromFirebase: &self.locationsFromFirebase)
        }
    }
    
    func addUserToFirebase(userLocation: CLLocationCoordinate2D) {
        if let email = Auth.auth().currentUser?.email , let userID = Auth.auth().currentUser?.uid {
            let userDataDictionary : [String:Any] = ["email" : email, "lat" : userLocation.latitude, "lon" : userLocation.longitude]
            ref.child("UserLocation").child(userID).setValue(userDataDictionary)
        }
    }
    
    func updateMap() {
        presenter?.createAnnotations(locationsFromFirebase: &locationsFromFirebase)
    }
    
}
