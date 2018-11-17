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
    
    static func configure(logInViewRef: LogInViewController) {
        let presenter: LogInPresenterProtocol & LogInOutputInteractorProtocol = LogInPresenter()
        let interactor = LogInInteractor()
        let router = LogInRouter()
        
        logInViewRef.presenter = presenter
        logInViewRef.presenter?.router = router
        logInViewRef.presenter?.interactor = interactor
        logInViewRef.presenter?.view = logInViewRef
        logInViewRef.presenter?.interactor?.presenter = presenter
    }
}
