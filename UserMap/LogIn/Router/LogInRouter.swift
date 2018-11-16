//
//  LogInRouter.swift
//  UserMap
//
//  Created by Max Rybak on 11/16/18.
//  Copyright © 2018 Max Rybak. All rights reserved.
//

import UIKit

class LogInRouter: LogInRouterProtocol {
    
    func segueToMap(from view: LogInViewController) {
         view.performSegue(withIdentifier: "segueToMap", sender: view)
    }
    
    static func createLogInModule(logInViewRef: LogInViewController) {
        let presenter: LogInPresenterProtocol & LogInOutputInteractorProtocol = LogInPresenter()
        
        logInViewRef.presenter = presenter
        logInViewRef.presenter?.router = LogInRouter()
        logInViewRef.presenter?.interactor = LogInInteractor()
        logInViewRef.presenter?.view = logInViewRef
        logInViewRef.presenter?.interactor?.presenter = presenter
    }
    
}
