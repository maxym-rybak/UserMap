//
//  LogInPresenter.swift
//  UserMap
//
//  Created by Max Rybak on 11/16/18.
//  Copyright © 2018 Max Rybak. All rights reserved.
//

import Foundation

class LogInPresenter: LogInPresenterProtocol {
 
    var interactor: LogInInputInteractorProtocol?
    var view: LogInViewProtocol?
    var router: LogInRouterProtocol?
    
    func signInAttemp(userEnterData: EnteredUserData) {
        view?.showActivityIndicator()
        interactor?.signInRequest(userEnterData: userEnterData)
    }
    
    func signUpAttemp(userEnterData: EnteredUserData) {
        view?.showActivityIndicator()
        interactor?.signUpRequest(userEnterData: userEnterData)
    }
    
}

extension LogInPresenter: LogInOutputInteractorProtocol {
    func performLogIn() {
        view?.hideActivityIndicator()
        router?.segueToMap(from: self.view as! LogInViewController)
    }
    
    func showError(error: Error) {
        view?.hideActivityIndicator()
        view?.displayAlert(title: "error", message: (error.localizedDescription))
    }
    
    func changeSingInToLogIn () {
        view?.singUpInSwitch()
    }

}

