//
//  MyLocations.swift
//  MyLocations
//
//  Created by Hector Enrique Gomez Morales on 1/26/15.
//  Copyright (c) 2015 Hector Enrique Gomez Morales. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation

class Locations: NSManagedObject {

    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var date: NSDate
    @NSManaged var locationDescription: String
    @NSManaged var category: String
    @NSManaged var placemark: CLPlacemark?

}
