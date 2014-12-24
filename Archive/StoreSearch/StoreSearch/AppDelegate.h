//
//  AppDelegate.h
//  StoreSearch
//
//  Created by Hector Enrique Gomez Morales on 7/5/14.
//  Copyright (c) 2014 Hector Enrique Gomez Morales. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UISplitViewController *splitViewController;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SearchViewController *searchViewController;
@end
