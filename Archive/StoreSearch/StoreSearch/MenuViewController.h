//
//  MenuViewController.h
//  StoreSearch
//
//  Created by Hector Enrique Gomez Morales on 7/11/14.
//  Copyright (c) 2014 Hector Enrique Gomez Morales. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MenuViewController : UITableViewController
@property (nonatomic, weak) DetailViewController *detailViewController;
@end
