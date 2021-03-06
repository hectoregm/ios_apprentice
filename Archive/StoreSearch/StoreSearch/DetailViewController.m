//
//  DetailViewController.m
//  StoreSearch
//
//  Created by Hector Enrique Gomez Morales on 7/9/14.
//  Copyright (c) 2014 Hector Enrique Gomez Morales. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "DetailViewController.h"
#import "SearchResult.h"
#import "GradientView.h"
#import "MenuViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <MessageUI/MessageUI.h>


@interface DetailViewController () <UIGestureRecognizerDelegate, MFMailComposeViewControllerDelegate>
@property (nonatomic, weak) IBOutlet UIView *popupView;
@property (nonatomic, weak) IBOutlet UIImageView *artworkImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *artistNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *kindLabel;
@property (nonatomic, weak) IBOutlet UILabel *genreLabel;
@property (nonatomic, weak) IBOutlet UIButton *priceButton;
@property (nonatomic, weak) IBOutlet UIButton *closeButton;
@property (nonatomic, strong) UIPopoverController *masterPopoverController;
@property (nonatomic, strong) UIPopoverController *menuPopoverController;
@end

@implementation DetailViewController
{
    GradientView *_gradientView;
}

- (UIPopoverController *)menuPopoverController
{
    if (_menuPopoverController == nil) {
        MenuViewController *menuViewController = [[MenuViewController alloc] initWithStyle:UITableViewStyleGrouped];
        menuViewController.detailViewController = self;
        _menuPopoverController = [[UIPopoverController alloc] initWithContentViewController:menuViewController];
    }
    
    return _menuPopoverController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.searchResult != nil) {
        [self updateUI];
    }
    
    self.popupView.layer.cornerRadius = 10.0f;
    
    UIImage *image = [[UIImage imageNamed:@"PriceButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.priceButton setBackgroundImage:image forState:UIControlStateNormal];
    self.view.tintColor = [UIColor colorWithRed:20/255.0f green:160/255.0f blue:160/255.0f alpha:1.0f];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        self.title = [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleDisplayName"];
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LandscapeBackground"]];
        
        self.popupView.hidden = (self.searchResult == nil);
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(menuButtonPressed:)];
    } else {
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close:)];
        gestureRecognizer.cancelsTouchesInView = NO;
        gestureRecognizer.delegate = self;
        [self.view addGestureRecognizer:gestureRecognizer];
        self.view.backgroundColor = [UIColor clearColor];
    }
}

- (void)setSearchResult:(SearchResult *)newSearchResult
{
    if (_searchResult != newSearchResult) {
        _searchResult = newSearchResult;
        
        if ([self isViewLoaded]) {
            [self updateUI];
        }
    }
}

#pragma mark - UISplitViewControllerDelegate

- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc
{
    barButtonItem.title = NSLocalizedString(@"Search", @"Split-view master button");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = pc;
}

- (void)splitViewController:(UISplitViewController *)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (void)splitViewController:(UISplitViewController *)svc
          popoverController:(UIPopoverController *)pc
  willPresentViewController:(UIViewController *)aViewController
{
    if ([self.menuPopoverController isPopoverVisible]) {
        [self.menuPopoverController dismissPopoverAnimated:YES];
    }
}

- (void)updateUI
{
    self.nameLabel.text = self.searchResult.name;
    NSString *artistName = self.searchResult.artistName;
    if (artistName == nil) {
        artistName = @"Unknown";
    }
    self.artistNameLabel.text = artistName;
    self.kindLabel.text = [self.searchResult kindForDisplay];
    self.genreLabel.text = self.searchResult.genre;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencyCode:self.searchResult.currency];
    
    NSString *priceText;
    if ([self.searchResult.price floatValue] == 0.0f) {
        priceText = @"Free";
    } else {
        priceText = [formatter stringFromNumber:self.searchResult.price];
    }
    
    [self.priceButton setTitle:priceText forState:UIControlStateNormal];
    
    [self.artworkImageView setImageWithURL:[NSURL URLWithString:self.searchResult.artworkURL100] placeholderImage:[UIImage imageNamed:@"Placeholder"]];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.popupView.alpha = 0.0f;
        [UIView animateWithDuration:0.5 animations:^{
            self.popupView.hidden = NO;
            self.popupView.alpha = 1.0f;
        } completion:nil];
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

- (IBAction)openInStore:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.searchResult.storeURL]];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return (touch.view == self.view);
}

- (void)presentInParentViewController:(UIViewController *)parentViewController
{
    _gradientView = [[GradientView alloc] initWithFrame:parentViewController.view.bounds];
    [parentViewController.view addSubview:_gradientView];
    
    self.view.frame = parentViewController.view.bounds;
    [parentViewController.view addSubview:self.view];
    [parentViewController addChildViewController:self];
    
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    bounceAnimation.duration = 0.4;
    bounceAnimation.delegate = self;
    
    bounceAnimation.values = @[@0.7, @1.2, @0.9, @1.0];
    bounceAnimation.keyTimes = @[@0.0, @0.334, @0.666, @1.0];
    
    bounceAnimation.timingFunctions = @[
                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                        ];
    
    [self.view.layer addAnimation:bounceAnimation forKey:@"bounceAnimation"];
    
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.fromValue = @0.0f;
    fadeAnimation.toValue = @1.0f;
    fadeAnimation.duration = 0.2;
    [_gradientView.layer addAnimation:fadeAnimation forKey:@"fadeAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self didMoveToParentViewController:self.parentViewController];
}

- (IBAction)close:(id)sender
{
    [self dismissFromParentViewController:DetailViewControllerAnimationTypeSlide];
}

- (void)dismissFromParentViewController:(DetailViewControllerAnimationType)animationType
{
    [self willMoveToParentViewController:nil];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (animationType == DetailViewControllerAnimationTypeSlide) {
            CGRect rect = self.view.bounds;
            rect.origin.y += rect.size.height;
            self.view.frame = rect;
        } else {
            self.view.alpha = 0.0f;
        }
        _gradientView.alpha = 0.0f;
    } completion:^(BOOL finished){
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        [_gradientView removeFromSuperview];
    }];
}

- (void)menuButtonPressed:(UIBarButtonItem *)sender
{
    if ([self.menuPopoverController isPopoverVisible]) {
        [self.menuPopoverController dismissPopoverAnimated:YES];
    } else {
        [self.menuPopoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

- (void)sendSupportEmail
{
    [self.menuPopoverController dismissPopoverAnimated:YES];
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    controller.modalPresentationStyle = UIModalPresentationFormSheet;
    controller.mailComposeDelegate = self;
    
    if (controller != nil) {
        [controller setSubject:NSLocalizedString(@"Support Request", @"Email subject")];
        [controller setToRecipients:@[@"hectoregm@gmail.com"]];
        [self presentViewController:controller animated:YES completion:nil];
    }
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    NSLog(@"dealloc %@", self);
    [self.artworkImageView cancelImageRequestOperation];
}

@end
