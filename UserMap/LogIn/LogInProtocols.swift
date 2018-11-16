//
//  LogInProtocols.swift
//  UserMap
//
//  Created by Max Rybak on 11/15/18.
//  Copyright © 2018 Max Rybak. All rights reserved.
//

import Foundation

/********************* ~Sample 2~ ****************************/

protocol LogInViewProtocol: class {
    // PRESENTER -> VIEW
    
    // Sign In, Sing up
    // Alert
    
//    func showFruits(with fruits: [Fruit])
    
}

protocol LogInPresenterProtocol: class {
    //View -> Presenter
    var interactor: LogInInputInteractorProtocol? {get set}
    var view: LogInViewProtocol? {get set}
    var router: LogInRouterProtocol? {get set}
//
//    func viewDidLoad()
//    func showFruitSelection(with fruit: Fruit, from view: UIViewController)
}

protocol LogInInputInteractorProtocol: class {
//    var presenter: FruitListOutputInteractorProtocol? {get set}
    //Presenter -> Interactor
//    func getFruitList()
}

protocol LogInOutputInteractorProtocol: class {
    //Interactor -> Presenter
//    func fruitListDidFetch(fruitList: [Fruit])
}

protocol LogInRouterProtocol: class {
    //Presenter -> Wireframe
//    func pushToFruitDetail(with fruit: Fruit,from view: UIViewController)
//    static func createFruitListModule(fruitListRef: FruitListView)
}
