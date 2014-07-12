//
//  DetailViewController.h
//  StoreSearch
//
//  Created by Hector Enrique Gomez Morales on 7/9/14.
//  Copyright (c) 2014 Hector Enrique Gomez Morales. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchResult;

typedef NS_ENUM(NSUInteger, DetailViewControllerAnimationType) {
    DetailViewControllerAnimationTypeSlide,
    DetailViewControllerAnimationTypeFade
};

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>
@property (nonatomic, strong) SearchResult *searchResult;

- (void)presentInParentViewController:(UIViewController *)parentViewController;

- (void)dismissFromParentViewController:(DetailViewControllerAnimationType)animationType;

@end
