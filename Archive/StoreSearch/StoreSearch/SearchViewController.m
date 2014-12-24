//
//  SearchViewController.m
//  StoreSearch
//
//  Created by Hector Enrique Gomez Morales on 7/5/14.
//  Copyright (c) 2014 Hector Enrique Gomez Morales. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "SearchViewController.h"
#import "DetailViewController.h"
#import "LandscapeViewController.h"
#import "SearchResult.h"
#import "SearchResultCell.h"
#import "Search.h"

static NSString * const SearchResultCellIdentifier = @"SearchResultCell";
static NSString * const NothingFoundCellIdentifier = @"NothingFoundCell";
static NSString * const LoadingCellIdentifier = @"LoadingCell";

@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;
@end

@implementation SearchViewController
{
    Search *_search;
    LandscapeViewController *_landscapeViewController;
    UIStatusBarStyle _statusBarStyle;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return _statusBarStyle;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _statusBarStyle = UIStatusBarStyleDefault;
    
    self.tableView.contentInset = UIEdgeInsetsMake(108, 0, 0, 0);
    self.tableView.rowHeight = 80;

    UINib *cellNib = [UINib nibWithNibName:SearchResultCellIdentifier bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:SearchResultCellIdentifier];
    
    cellNib = [UINib nibWithNibName:NothingFoundCellIdentifier bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:NothingFoundCellIdentifier];
    
    cellNib = [UINib nibWithNibName:LoadingCellIdentifier bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:LoadingCellIdentifier];
    
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
        [self.searchBar becomeFirstResponder];
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
        if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
            [self hideLandscapeViewWithDuration:duration];
        } else {
            [self showLandscapeViewWithDuration:duration];
        }
    }
}

- (void)showLandscapeViewWithDuration:(NSTimeInterval)duration
{
    if (_landscapeViewController == nil) {
        [self.searchBar resignFirstResponder];
        _landscapeViewController = [[LandscapeViewController alloc] initWithNibName:@"LandscapeViewController" bundle:nil];
        _landscapeViewController.search= _search;
        _landscapeViewController.view.frame = self.view.bounds;
        _landscapeViewController.view.alpha = 0.0f;
        
        [self.view addSubview:_landscapeViewController.view];
        [self addChildViewController:_landscapeViewController];
        
        [UIView animateWithDuration:duration animations:^{
            _landscapeViewController.view.alpha = 1.0f;
            _statusBarStyle = UIStatusBarStyleLightContent;
            [self setNeedsStatusBarAppearanceUpdate];
        } completion:^(BOOL finished){
            [_landscapeViewController didMoveToParentViewController:self];
        }];
        [self.detailViewController dismissFromParentViewController:DetailViewControllerAnimationTypeFade];
    }
}

- (void)hideLandscapeViewWithDuration:(NSTimeInterval)duration
{
    if (_landscapeViewController != nil) {
        [_landscapeViewController willMoveToParentViewController:nil];
        
        [UIView animateWithDuration:duration animations:^{
            _landscapeViewController.view.alpha = 0.0f;
            _statusBarStyle = UIStatusBarStyleDefault;
            [self setNeedsStatusBarAppearanceUpdate];
        } completion:^(BOOL finished) {
            [_landscapeViewController.view removeFromSuperview];
            [_landscapeViewController removeFromParentViewController];
            _landscapeViewController = nil;
        }];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_search == nil) {
        return 0; // Not searched yet
    } else if (_search.isLoading) {
        return 1; // Loading...
    } else if ([_search.searchResults count] == 0) {
        return 1; // Nothing found
    } else {
        return [_search.searchResults count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_search.isLoading) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LoadingCellIdentifier];
        UIActivityIndicatorView *spinner = (UIActivityIndicatorView *)[cell viewWithTag:100];
        [spinner startAnimating];
        
        return cell;
    } else if ([_search.searchResults count] == 0) {
        return [tableView dequeueReusableCellWithIdentifier:NothingFoundCellIdentifier forIndexPath:indexPath];
    } else {
        SearchResultCell *cell = (SearchResultCell *)[tableView dequeueReusableCellWithIdentifier:SearchResultCellIdentifier
                                                                                     forIndexPath:indexPath];
        SearchResult *searchResult = _search.searchResults[indexPath.row];
        [cell configureForSearchResult:searchResult];

        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.searchBar resignFirstResponder];
    SearchResult *searchResult = _search.searchResults[indexPath.row];
    
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];

        DetailViewController *controller = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
        controller.searchResult = searchResult;
        [controller presentInParentViewController:self];
        self.detailViewController = controller;
    } else {
        self.detailViewController.searchResult = searchResult;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_search.searchResults count] == 0 || _search.isLoading) {
        return nil;
    } else {
        return indexPath;
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self performSearch];
}

- (void)performSearch
{
    _search = [[Search alloc] init];
    NSLog(@"allocated %@", _search);
    [_search performSearchForText:self.searchBar.text
                         category:self.segmentedControl.selectedSegmentIndex
                       completion:^(BOOL success) {
                           if (!success) {
                               [self showNetworkError];
                           }
                           
                           [_landscapeViewController searchResultsReceived];
                           [self.tableView reloadData];
                       }];
    
    [self.tableView reloadData];
    [self.searchBar resignFirstResponder];
}

- (void)showNetworkError
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Whoops..."
                                                        message:@"There was an error reading from the iTunes Store. Please try again."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar
{
    return UIBarPositionTopAttached;
}

- (IBAction)segmentChanged:(UISegmentedControl *)sender
{
    if (_search != nil) {
        [self performSearch];
    }
}

@end
