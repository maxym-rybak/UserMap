//
//  MapPresenter.swift
//  UserMap
//
//  Created by Max Rybak on 11/16/18.
//  Copyright © 2018 Max Rybak. All rights reserved.
//

class MapPresenter: MapPresenterProtocol {

    var interactor: MapInputInteractorProtocol?
    var view: MapViewProtocol?
    var router: MapRouterProtocol?

    func addUserIntention(userLocation: UserCoords) {
        interactor?.addUserToFirebase(userLocation: userLocation)
        interactor?.updateMap()
    }
    
    func mapUpdateIntention() {
        interactor?.updateMap()
    }
    
    func makeLogOutIntention() {
        router?.logOut(from: view as! MapViewController)
    }
    
    func userListOpenCloseIntention() {
        view?.userListOpenClose()
    }
}

extension MapPresenter: MapOutputInteractorProtocol {
    
    func createAnnotations(locationsFromFirebase: inout [UserCoords]) {
        view?.addAnnotationsToMap(userLocation: &locationsFromFirebase)
    }
    
}
