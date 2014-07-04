//
//  FirstViewController.h
//  MyLocations
//
//  Created by Hector Enrique Gomez Morales on 6/27/14.
//  Copyright (c) 2014 Hector Enrique Gomez Morales. All rights reserved.
//

@interface CurrentLocationViewController : UIViewController <CLLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet UILabel *messageLabel;
@property (nonatomic, weak) IBOutlet UILabel *latitudeLabel;
@property (nonatomic, weak) IBOutlet UILabel *longitudeLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UIButton *tagButton;
@property (nonatomic, weak) IBOutlet UIButton *getButton;
@property (nonatomic, weak) IBOutlet UILabel *latitudeTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *longitudeTextLabel;
@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (IBAction)getLocation:(id)sender;

@end
