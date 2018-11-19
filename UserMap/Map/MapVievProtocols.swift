//
//  MapVievProtocols.swift
//  UserMap
//
//  Created by Max Rybak on 11/16/18.
//  Copyright © 2018 Max Rybak. All rights reserved.
//

protocol MapViewProtocol: class {
    // PRESENTER -> VIEW
    func addAnnotationsToMap(userLocation: inout [UserCoords])
    func userListOpenClose()
}

protocol MapPresenterProtocol: class {
    //View -> Presenter
    var interactor: MapInputInteractorProtocol? {get set}
    var view: MapViewProtocol? {get set}
    var router: MapRouterProtocol? {get set}
    
    func addUserIntention(userLocation: UserCoords)
    func mapUpdateIntention()
    func makeLogOutIntention()
    func userListOpenCloseIntention()
}

protocol MapInputInteractorProtocol: class {
    var presenter: MapOutputInteractorProtocol? {get set}
    //Presenter -> Interactor
    func addUserToFirebase(userLocation: UserCoords)
    func updateMap()
}

protocol MapOutputInteractorProtocol: class {
    //Interactor -> Presenter
    func createAnnotations(locationsFromFirebase: inout [UserCoords])
}

protocol MapRouterProtocol: class {
    //Presenter -> Router
    func logOut(from view: MapViewController)
    static func configure(mapViewRef: MapViewController)
}
