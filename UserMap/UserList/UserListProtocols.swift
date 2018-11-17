//
//  UserListProtocols.swift
//  UserMap
//
//  Created by Max Rybak on 11/17/18.
//  Copyright © 2018 Max Rybak. All rights reserved.
//

protocol UserListViewProtocol: class {
    // PRESENTER -> VIEW
    func showUsers(usernames: inout [String])
}

protocol UserListPresenterProtocol: class {
    //View -> Presenter
    var interactor: UserListInputInteractorProtocol? {get set}
    var view: UserListViewProtocol? {get set}
    var router: UserListRouterProtocol? {get set}
    
    func loadUsersAttemp()
}

protocol UserListInputInteractorProtocol: class {
    var presenter: UserListOutputInteractorProtocol? {get set}
    //Presenter -> Interactor
    func loadUsersFromFirebase()
}

protocol UserListOutputInteractorProtocol: class {
    //Interactor -> Presenter
    func showUserList(usernames: inout [String])
}

protocol UserListRouterProtocol: class {
    //Presenter -> Router
    static func configure(userListViewRef: UserListTableViewController)
}
