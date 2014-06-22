//
//  AddItemViewController.h
//  Checklists
//
//  Created by Hector Enrique Gomez Morales on 6/22/14.
//  Copyright (c) 2014 Hector Enrique Gomez Morales. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddItemViewController;
@class ChecklistItem;
@protocol AddItemViewControllerDelegate <NSObject>

- (void)addItemViewControllerDidCancel:(AddItemViewController *)controller;
- (void)addItemViewController:(AddItemViewController *)controller didFinishAddingItem:(ChecklistItem *)item;

@end

@interface AddItemViewController : UITableViewController<UITextFieldDelegate>
@property (weak, nonatomic) id <AddItemViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;

- (IBAction)cancel;
- (IBAction)done;

@end
