//
//  UserListRouter.swift
//  UserMap
//
//  Created by Max Rybak on 11/17/18.
//  Copyright © 2018 Max Rybak. All rights reserved.
//

class UserListRouter: UserListRouterProtocol {
    
    static func configure(userListViewRef: UserListTableViewController) {
        let presenter: UserListPresenterProtocol & UserListOutputInteractorProtocol = UserListPresenter()
        let interactor = UserListInteractor()
        let router = UserListRouter()
        
        userListViewRef.presenter = presenter
        userListViewRef.presenter?.interactor = interactor
        userListViewRef.presenter?.router = router
        userListViewRef.presenter?.view = userListViewRef
        userListViewRef.presenter?.interactor?.presenter = presenter
    }
    
}
