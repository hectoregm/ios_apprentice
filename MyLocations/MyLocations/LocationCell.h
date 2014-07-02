//
//  LocationCell.h
//  MyLocations
//
//  Created by Hector Enrique Gomez Morales on 7/1/14.
//  Copyright (c) 2014 Hector Enrique Gomez Morales. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;

@end
