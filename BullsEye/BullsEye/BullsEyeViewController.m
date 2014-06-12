//
//  BullsEyeViewController.m
//  BullsEye
//
//  Created by Hector Enrique Gomez Morales on 6/11/14.
//  Copyright (c) 2014 Hector Enrique Gomez Morales. All rights reserved.
//

#import "BullsEyeViewController.h"

@interface BullsEyeViewController ()

@end

@implementation BullsEyeViewController
{
    int _currentValue;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _currentValue = 50;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sliderMoved:(UISlider *)slider
{
    _currentValue = lround(slider.value);
}

- (IBAction)showAlert
{
    NSString *message = [NSString stringWithFormat: @"The value of the slider is: %d", _currentValue];
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle: @"Hello, World"
                              message: message
                              delegate: nil
                              cancelButtonTitle: @"OK"
                              otherButtonTitles: nil];
    [alertView show];
}

@end
