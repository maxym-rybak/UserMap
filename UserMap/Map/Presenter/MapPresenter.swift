//
//  MapPresenter.swift
//  UserMap
//
//  Created by Max Rybak on 11/16/18.
//  Copyright © 2018 Max Rybak. All rights reserved.
//

import FirebaseDatabase
import FirebaseAuth
import MapKit

class MapPresenter: MapPresenterProtocol {

    var interactor: MapInputInteractorProtocol?
    var view: MapViewProtocol?
    var router: MapRouterProtocol?

    func addUserIntention(userLocation: CLLocationCoordinate2D) {
        interactor?.addUserToFirebase(userLocation: userLocation)
        interactor?.updateMap()
    }
    
    func mapUpdateIntention() {
        interactor?.updateMap()
    }
    
}

extension MapPresenter: MapOutputInteractorProtocol {
    
    func createAnnotations(locationsFromFirebase: inout [DataSnapshot]) {
        var allAnnotations = [MKPointAnnotation]()
        for elem in locationsFromFirebase {
            if let userDictionary = elem.value as? [String:AnyObject] {
                if let email = userDictionary["email"] as? String
                    , let lat = userDictionary["lat"] as? Double
                    , let lon = userDictionary["lon"] as? Double {
                    let newAnnotation = MKPointAnnotation()
                    newAnnotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                    newAnnotation.title = email
                    allAnnotations.append(newAnnotation)
                }
            }
        }
        view?.addAnnotationsToMap(annotations: &allAnnotations)
    }
    
}
