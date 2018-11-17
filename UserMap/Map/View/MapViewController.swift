//
//  MapViewController.swift
//  UserMap
//
//  Created by Max Rybak on 11/15/18.
//  Copyright © 2018 Max Rybak. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var presenter: MapPresenterProtocol?
    
    @IBOutlet weak var map: MKMapView!
    
    var userLocation = CLLocationCoordinate2D()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MapRouter.configure(mapViewRef: self)
        initLocationManager()
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func initLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coord = manager.location?.coordinate {
            let center = CLLocationCoordinate2D(latitude: coord.latitude, longitude: coord.longitude)
            let regior = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
            map.setRegion(regior, animated: true)
            userLocation = center
            map.removeAnnotations(map.annotations)
            
            presenter?.addUserIntention(userLocation: userLocation)
            presenter?.mapUpdateIntention()
        }
    }
}

extension MapViewController: MapViewProtocol {
    
    func addAnnotationsToMap(annotations: inout [MKPointAnnotation]) {
        map.addAnnotations(annotations)
    }
    
}
