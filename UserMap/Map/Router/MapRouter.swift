//
//  MapRouter.swift
//  UserMap
//
//  Created by Max Rybak on 11/16/18.
//  Copyright © 2018 Max Rybak. All rights reserved.
//

import UIKit

class MapRouter: MapRouterProtocol {
    
    static func configure(mapViewRef: MapViewController) {
        let presenter: MapPresenterProtocol & MapOutputInteractorProtocol = MapPresenter()
        let interactor = MapInteractor()
        let router = MapRouter()
        
        mapViewRef.presenter = presenter
        mapViewRef.presenter?.interactor = interactor
        mapViewRef.presenter?.router = router
        mapViewRef.presenter?.view = mapViewRef
        mapViewRef.presenter?.interactor?.presenter = presenter
    }
    
    func logOut(from view: MapViewController) {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
        view.performSegue(withIdentifier: "segueToLogIn", sender: self)
    }
}
