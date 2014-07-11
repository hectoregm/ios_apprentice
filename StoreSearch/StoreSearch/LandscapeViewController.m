//
//  LandscapeViewController.m
//  StoreSearch
//
//  Created by Hector Enrique Gomez Morales on 7/10/14.
//  Copyright (c) 2014 Hector Enrique Gomez Morales. All rights reserved.
//

#import "LandscapeViewController.h"
#import "SearchResult.h"
#import <AFNetworking/UIButton+AFNetworking.h>

@interface LandscapeViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;
@end

@implementation LandscapeViewController
{
    BOOL _firstTime;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _firstTime = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pageControl.numberOfPages = 0;
    self.scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LandscapeBackground"]];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    if (_firstTime) {
        _firstTime = NO;
        
        [self tileButtons];
    }
}

- (void)tileButtons
{
    int columnsPerPage = 5;
    CGFloat itemWidth = 96.0f;
    CGFloat x = 0.0f;
    CGFloat extraSpace = 0.0f;
    
    CGFloat scrollViewWidth = self.scrollView.bounds.size.width;
    if (scrollViewWidth > 480.0f) {
        columnsPerPage = 6;
        itemWidth = 94.0f;
        x = 2.0f;
        extraSpace = 4.0f;
    }
    
    const CGFloat itemHeight = 88.0f;
    const CGFloat buttonWidth = 82.0f;
    const CGFloat buttonHeight = 82.0f;
    const CGFloat marginHorz = (itemWidth - buttonWidth)/2.0f;
    const CGFloat marignVert = (itemHeight - buttonHeight)/2.0f;
    
    int index = 0;
    int row = 0;
    int column = 0;
    
    for (SearchResult *searchResult in self.searchResults) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self downloadImageForSearchResult:searchResult andPlaceOnButton:button];
        [button setBackgroundImage:[UIImage imageNamed:@"LandscapeButton"] forState:UIControlStateNormal];
        
        button.frame = CGRectMake(x + marginHorz, 20.0f + row*itemHeight + marignVert, buttonWidth, buttonHeight);
        
        [self.scrollView addSubview:button];
        
        index++;
        row++;
        if (row == 3) {
            row = 0;
            column++;
            x += itemWidth;
            
            if (column == columnsPerPage) {
                column = 0;
                x += extraSpace;
            }
        }
    }
    
    int tilesPerPage = columnsPerPage * 3;
    int numPages = ceilf([self.searchResults count] / (float)tilesPerPage);
    self.scrollView.contentSize = CGSizeMake(numPages*scrollViewWidth, self.scrollView.bounds.size.height);
    
    self.pageControl.numberOfPages = numPages;
    self.pageControl.currentPage = 0;
    NSLog(@"Number of pages: %d", numPages);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = self.scrollView.bounds.size.width;
    int currentPage = (self.scrollView.contentOffset.x + width/2.0f) / width;
    self.pageControl.currentPage = currentPage;
}

- (IBAction)pageChanged:(UIPageControl *)sender
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.scrollView.contentOffset = CGPointMake(self.scrollView.bounds.size.width * sender.currentPage, 0);
                     }
                     completion:nil];
}

- (void)downloadImageForSearchResult:(SearchResult *)searchResult andPlaceOnButton:(UIButton *)button
{
    NSURL *url = [NSURL URLWithString:searchResult.artworkURL60];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    
    __weak UIButton *weakButton = button;
    [button setImageForState:UIControlStateNormal
              withURLRequest:request
            placeholderImage:nil
                     success:^(NSHTTPURLResponse *response, UIImage *image) {
                         UIImage *unscaledImage = [UIImage imageWithCGImage:image.CGImage
                                                                      scale:1.0 orientation:image.imageOrientation];
                         [weakButton setImage:unscaledImage forState:UIControlStateNormal];
                   } failure:nil];
}

- (void)dealloc
{
    NSLog(@"dealloc %@", self);
    
    for (UIButton *button in self.scrollView.subviews) {
        [button cancelImageRequestOperation];
    }
}

@end
