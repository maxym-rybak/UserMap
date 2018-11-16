//
//  MapViewController.swift
//  UserMap
//
//  Created by Max Rybak on 11/15/18.
//  Copyright © 2018 Max Rybak. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase
import FirebaseAuth

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    var ref: DatabaseReference!
    var otherUsersLocations: [DataSnapshot] = []
    
    var locationManager = CLLocationManager()
    var userLocation = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        ref = Database.database().reference()

        ref.child("UserLocation").observe(.childAdded) {
            (snapshot) in
            self.otherUsersLocations.append(snapshot)
            self.addAllLocationsFromFirebaseToMap()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coord = manager.location?.coordinate {
            let center = CLLocationCoordinate2D(latitude: coord.latitude, longitude: coord.longitude)
            let regior = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
            map.setRegion(regior, animated: true)
            userLocation = center
            map.removeAnnotations(map.annotations)
            
            addUserLocationToFirebase()
            addAllLocationsFromFirebaseToMap()
        }
    }
    
    func addAllLocationsFromFirebaseToMap () {
        var allAnnotations = [MKPointAnnotation]()
        for elem in otherUsersLocations {
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
        map.addAnnotations(allAnnotations)
    }
    
    func addUserLocationToFirebase () {
        if let email = Auth.auth().currentUser?.email , let userID = Auth.auth().currentUser?.uid {
            let userDataDictionary : [String:Any] = ["email" : email, "lat" : userLocation.latitude, "lon" : userLocation.longitude]
            ref.child("UserLocation").child(userID).setValue(userDataDictionary)
        }
    }

}
