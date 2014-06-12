//
//  BullsEyeViewController.h
//  BullsEye
//
//  Created by Hector Enrique Gomez Morales on 6/11/14.
//  Copyright (c) 2014 Hector Enrique Gomez Morales. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BullsEyeViewController : UIViewController

@property (nonatomic, weak) IBOutlet UISlider *slider;
@property (nonatomic, weak) IBOutlet UILabel *targetLabel;
@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak) IBOutlet UILabel *roundLabel;


- (IBAction)sliderMoved:(UISlider *)slider;

- (IBAction)showAlert;

@end
