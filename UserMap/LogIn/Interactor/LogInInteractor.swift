//
//  LogInInteractor.swift
//  UserMap
//
//  Created by Max Rybak on 11/16/18.
//  Copyright © 2018 Max Rybak. All rights reserved.
//

import UIKit
import Firebase

class LogInInteractor: LogInInputInteractorProtocol {
    
    var presenter: LogInOutputInteractorProtocol?
    
    func signInRequest(userEnterData: EnteredUserData) {
        Auth.auth().signIn(withEmail: userEnterData.username, password: userEnterData.password, completion: {
            (user, error) in
            if error != nil {
                self.presenter?.showError(error: error!)
            } else {
                self.presenter?.performLogIn()
            }
        } )
    }
    
    func signUpRequest(userEnterData: EnteredUserData) {
        Auth.auth().createUser(withEmail: userEnterData.username, password: userEnterData.password, completion: {
            (user, error) in
            if error != nil {
                self.presenter?.showError(error: error!)
            } else {
                self.presenter?.changeSingInToLogIn()
            }
        } )
    }

}
