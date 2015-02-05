//
//  MapViewController.swift
//  MyLocations
//
//  Created by Hector Enrique Gomez Morales on 2/4/15.
//  Copyright (c) 2015 Hector Enrique Gomez Morales. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    var locations = [Location]()
    
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLocations()
    }
    
    @IBAction func showUser() {
        let region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 1000, 1000)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
    
    @IBAction func showLocations() {
        
    }

    func updateLocations() {
        let entity = NSEntityDescription.entityForName("Location", inManagedObjectContext: managedObjectContext)
        
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entity
        
        var error: NSError?
        let foundObjects = managedObjectContext.executeFetchRequest(fetchRequest, error: &error)
        
        if foundObjects == nil {
            fatalCoreDataError(error)
            return
        }
        
        mapView.removeAnnotations(locations)
        
        locations = foundObjects as [Location]
        mapView.addAnnotations(locations)
    }
}

extension MapViewController: MKMapViewDelegate {
    
}
