//
//  ChecklistsViewController.h
//  Checklists
//
//  Created by Hector Enrique Gomez Morales on 6/21/14.
//  Copyright (c) 2014 Hector Enrique Gomez Morales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"

@class Checklist;

@interface ChecklistViewController : UITableViewController<ItemDetailViewControllerDelegate>

@property (nonatomic, strong) Checklist *checklist;

@end
