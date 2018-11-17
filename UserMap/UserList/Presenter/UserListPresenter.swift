//
//  UserListPresenter.swift
//  UserMap
//
//  Created by Max Rybak on 11/17/18.
//  Copyright © 2018 Max Rybak. All rights reserved.
//

class UserListPresenter: UserListPresenterProtocol {
    
    var interactor: UserListInputInteractorProtocol?
    var view: UserListViewProtocol?
    var router: UserListRouterProtocol?
    
    func loadUsersAttemp() {
        interactor?.loadUsersFromFirebase()
    }
    
}

extension UserListPresenter: UserListOutputInteractorProtocol {
    
    func showUserList(usernames: inout [String]) {
        view?.showUsers(usernames: &usernames)
    }
    
}
