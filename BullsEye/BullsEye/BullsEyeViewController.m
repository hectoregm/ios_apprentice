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
    int _targetValue;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startNewRound];
    [self updateLabels];
}

- (void)updateLabels
{
    self.targetLabel.text = [NSString stringWithFormat:@"%d", _targetValue];
}

- (void)startNewRound
{
    _targetValue = 1 + arc4random_uniform(100);
    _currentValue = 50;
    self.slider.value = _currentValue;
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
    NSString *message = [NSString stringWithFormat: @"The value of the slider is: %d\nThe target value is: %d", _currentValue, _targetValue];
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle: @"Hello, World"
                              message: message
                              delegate: nil
                              cancelButtonTitle: @"OK"
                              otherButtonTitles: nil];
    [alertView show];
    
    [self startNewRound];
    [self updateLabels];
}

@end
