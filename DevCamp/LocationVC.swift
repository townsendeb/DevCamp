//
//  SecondViewController.swift
//  DevCamp
//
//  Created by Eric Townsend on 1/25/16.
//  Copyright © 2016 KrimsonTech. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class LocationVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var map: MKMapView!
    
    let regionRadius: CLLocationDistance = 1000
    let locationManager = CLLocationManager()
    
    let addresses = [
    "20433 Via San Marino, Cupertino, CA 95014",
    "20650 Homestead Rd, Cupertino, CA 95014",
    "11010 N De Anza Blvd, Cupertino, CA, 95014"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        map.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        for add in addresses {
            getPlacemarkFromAddress(add)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        locationAuthStatus()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView,  didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    //ask the user if we are allowed to use location
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            map.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    //lets the app center down on your location
    func centerMapOnLocation (location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 5, regionRadius * 5)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    
    //keeps the location of the User updated
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        if let loc = userLocation.location {
            centerMapOnLocation(loc)
        }
    }
    // lets you edit the pins on the maps, add names and such
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKindOfClass(BootCampAnnotation) {
            let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
            annoView.pinTintColor = UIColor.purpleColor()
            annoView.animatesDrop = true
            return annoView
        } else if annotation.isKindOfClass(MKUserLocation) {
            return nil
        }
        return nil
    }
    
    //creates the annotation to drop the pin on the map
    func createAnnotationForLocation(location: CLLocation) {
        let bootcamp = BootCampAnnotation(coordinate: location.coordinate)
        map.addAnnotation(bootcamp)
    }
    
    //geolocation turns the addresses in the array to coordinates
    func getPlacemarkFromAddress(address: String) {
        CLGeocoder().geocodeAddressString(address) { (placemarks: [CLPlacemark]?, completionHandler: NSError?) -> Void in
            if let marks = placemarks where marks.count > 0 {
                if let loc = marks[0].location {
                    //shows we have a valid location if we get this far
                   self.createAnnotationForLocation(loc)
            }
        }
    }
    
}
}

