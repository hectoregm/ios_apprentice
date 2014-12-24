//
//  LocationDetailsViewController.h
//  MyLocations
//
//  Created by Hector Enrique Gomez Morales on 6/29/14.
//  Copyright (c) 2014 Hector Enrique Gomez Morales. All rights reserved.
//

@class Location;

@interface LocationDetailsViewController : UITableViewController

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) CLPlacemark *placemark;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) Location *locationToEdit;

@end
