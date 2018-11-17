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
    var userDataFromFirebase: [DataSnapshot] = []
    var usernames: [String] = []
    
    func loadUsersFromFirebase() {
        ref = Database.database().reference()
        ref.child("UserLocation").observe(.childAdded) {
            (snapshot) in
            self.userDataFromFirebase.append(snapshot)
            for elem in self.userDataFromFirebase {
                if let userDictionary = elem.value as? [String:AnyObject] {
                    if let email = userDictionary["email"] as? String {
                        self.usernames.append(email)
                    }
                }
            }
            self.presenter?.showUserList(usernames: &self.usernames)
        }
    }
    
}
