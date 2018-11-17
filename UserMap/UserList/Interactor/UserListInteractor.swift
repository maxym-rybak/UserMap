//
//  UserListInteractor.swift
//  UserMap
//
//  Created by Max Rybak on 11/17/18.
//  Copyright © 2018 Max Rybak. All rights reserved.
//

import FirebaseDatabase

class UserListInteractor: UserListInputInteractorProtocol {
    
    weak var presenter: UserListOutputInteractorProtocol?
    
    var ref: DatabaseReference!
    var userLocations: [DataSnapshot] = []
    
    func loadUsersFromFirebase() {
        ref = Database.database().reference()
        ref.child("UserLocation").observe(.childAdded) {
            (snapshot) in
            self.userLocations.append(snapshot)
            self.presenter?.showUserList(userLocations: &self.userLocations)
        }
    }
    
}
