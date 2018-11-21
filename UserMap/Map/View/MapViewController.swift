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
    var allUsers: [UserCoords]?
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    var userLocation = CLLocationCoordinate2D()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MapRouter.configure(mapViewRef: self)
        initLocationManager()
        tableView.dataSource = self
        self.tableView.isHidden = true
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        presenter?.makeLogOutIntention()
    }
    
    // MARK: - Open/Close Tableview
    @IBAction func userListPressed(_ sender: UIBarButtonItem) {
        presenter?.view?.userListOpenClose()
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval)
    {
        UIView.animate(withDuration: 0.6, animations: {
            if toInterfaceOrientation == .landscapeLeft || toInterfaceOrientation == .landscapeRight{
                self.tableView.isHidden = false
            }
            else{
                self.tableView.isHidden = true
            }
        })
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    // MARK: - Setup Locationmanager
    func initLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coord = manager.location?.coordinate {
            let center = CLLocationCoordinate2D(latitude: coord.latitude, longitude: coord.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
            map.setRegion(region, animated: true)
            userLocation = center
            map.removeAnnotations(map.annotations)
            let currentUser = UserCoords(username: "Default", lat: userLocation.latitude, lon: userLocation.longitude)
            presenter?.addUserIntention(userLocation: currentUser)
            presenter?.mapUpdateIntention()
        }
    }
    
}

extension MapViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Tableview setup
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allUsers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        if let username = allUsers?[indexPath.row].username {
            cell.textLabel?.text = username
            cell.textLabel?.textColor = .white
        }
        return cell
    }
    
}

extension MapViewController: MapViewProtocol {

    // MARK: MapViewProtocol fuctions
    func addAnnotationsToMap(userLocation: inout [UserCoords]) {
        allUsers = userLocation
        var allAnnotations = [MKPointAnnotation]()
        for elem in userLocation {
                let newAnnotation = MKPointAnnotation()
                newAnnotation.coordinate = CLLocationCoordinate2D(latitude: elem.lat, longitude: elem.lon)
                newAnnotation.title = elem.username
                allAnnotations.append(newAnnotation)
        }
        map.addAnnotations(allAnnotations)
    }
    
    func userListOpenClose() {
        UIView.animate(withDuration: 0.6, animations: {
            self.tableView.isHidden = !(self.tableView.isHidden)
        })
    }
    
}
