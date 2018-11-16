//
//  LogInProtocols.swift
//  UserMap
//
//  Created by Max Rybak on 11/15/18.
//  Copyright © 2018 Max Rybak. All rights reserved.
//

import UIKit

protocol LogInViewProtocol: class {
    // PRESENTER -> VIEW

    func displayAlert(title: String, message: String)
    func showActivityIndicator()
    func hideActivityIndicator()
    func singUpInSwitch ()
}

protocol LogInPresenterProtocol: class {
    //View -> Presenter
    var interactor: LogInInputInteractorProtocol? {get set}
    var view: LogInViewProtocol? {get set}
    var router: LogInRouterProtocol? {get set}
    
    func signInAttemp(userEnterData: EnteredUserData)
    func signUpAttemp(userEnterData: EnteredUserData)
}

protocol LogInInputInteractorProtocol: class {
    var presenter: LogInOutputInteractorProtocol? {get set}
    //Presenter -> Interactor
    func signInRequest(userEnterData: EnteredUserData)
    func signUpRequest(userEnterData: EnteredUserData)
}

protocol LogInOutputInteractorProtocol: class {
    //Interactor -> Presenter
    func performLogIn()
    func showError(error: Error)
    func changeSingInToLogIn()
}

protocol LogInRouterProtocol: class {
    //Presenter -> Router
    func segueToMap(from view: LogInViewController)
    static func createLogInModule(logInViewRef: LogInViewController)
}
