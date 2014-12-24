//
//  LandscapeViewController.h
//  StoreSearch
//
//  Created by Hector Enrique Gomez Morales on 7/10/14.
//  Copyright (c) 2014 Hector Enrique Gomez Morales. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Search;

@interface LandscapeViewController : UIViewController
@property (nonatomic, strong) Search *search;

- (void)searchResultsReceived;
@end
