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
    
    
    
}

extension LogInPresenter: LogInOutputInteractorProtocol {
    
}

