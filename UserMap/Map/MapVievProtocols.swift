//
//  MapVievProtocols.swift
//  UserMap
//
//  Created by Max Rybak on 11/16/18.
//  Copyright © 2018 Max Rybak. All rights reserved.
//

import MapKit
import Firebase

protocol MapViewProtocol: class {
    // PRESENTER -> VIEW
    func addAnnotationsToMap(annotations: inout [MKPointAnnotation])
}

protocol MapPresenterProtocol: class {
    //View -> Presenter
    var interactor: MapInputInteractorProtocol? {get set}
    var view: MapViewProtocol? {get set}
    var router: MapRouterProtocol? {get set}
    
    func addUserIntention(userLocation: CLLocationCoordinate2D)
    func mapUpdateIntention()
}

protocol MapInputInteractorProtocol: class {
    var presenter: MapOutputInteractorProtocol? {get set}
    //Presenter -> Interactor
    func addUserToFirebase(userLocation: CLLocationCoordinate2D)
    func updateMap()
}

protocol MapOutputInteractorProtocol: class {
    //Interactor -> Presenter
    func createAnnotations(locationsFromFirebase: inout [DataSnapshot])
}

protocol MapRouterProtocol: class {
    //Presenter -> Router
    static func configure(mapViewRef: MapViewController)
}
