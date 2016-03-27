//
//  BootCampAnnotation.swift
//  DevCamp
//
//  Created by Eric Townsend on 1/25/16.
//  Copyright © 2016 KrimsonTech. All rights reserved.
//

import Foundation
import UIKit
import MapKit

//creates coordinate
class BootCampAnnotation: NSObject, MKAnnotation {
    var coordinate = CLLocationCoordinate2D()
    
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
