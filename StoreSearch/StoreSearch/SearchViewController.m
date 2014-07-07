//
//  SearchViewController.m
//  StoreSearch
//
//  Created by Hector Enrique Gomez Morales on 7/5/14.
//  Copyright (c) 2014 Hector Enrique Gomez Morales. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResult.h"
#import "SearchResultCell.h"

static NSString * const SearchResultCellIdentifier = @"SearchResultCell";
static NSString * const NothingFoundCellIdentifier = @"NothingFoundCell";

@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end

@implementation SearchViewController
{
    NSMutableArray *_searchResults;
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
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.rowHeight = 80;

    UINib *cellNib = [UINib nibWithNibName:SearchResultCellIdentifier bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:SearchResultCellIdentifier];
    
    cellNib = [UINib nibWithNibName:NothingFoundCellIdentifier bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:NothingFoundCellIdentifier];
    
    [self.searchBar becomeFirstResponder];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_searchResults == nil) {
        return 0;
    } else if ([_searchResults count] == 0) {
        return 1;
    } else {
        return [_searchResults count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_searchResults count] == 0) {
        return [tableView dequeueReusableCellWithIdentifier:NothingFoundCellIdentifier forIndexPath:indexPath];
    } else {
        SearchResultCell *cell = (SearchResultCell *)[tableView dequeueReusableCellWithIdentifier:SearchResultCellIdentifier
                                                                                     forIndexPath:indexPath];
        SearchResult *searchResult = _searchResults[indexPath.row];
        cell.nameLabel.text = searchResult.name;
        cell.artistNameLabel.text = searchResult.artistName;
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_searchResults count] == 0) {
        return nil;
    } else {
        return indexPath;
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if ([searchBar.text length] > 0) {
        [searchBar resignFirstResponder];
        
        _searchResults = [NSMutableArray arrayWithCapacity:10];
        
        NSURL *url = [self urlWithSearchText:searchBar.text];
        NSLog(@"URL '%@'", url);
        
        NSString *jsonString = [self performStoreRequestWithURL:url];
        NSLog(@"Received JSON string '%@'", jsonString);
        
        NSDictionary *dictionary = [self parseJSON:jsonString];
        NSLog(@"Dictionary %@", dictionary);
        
        [self.tableView reloadData];
    }
}

- (NSURL *)urlWithSearchText:(NSString *)searchText
{
    NSString *escapedSearchText = [searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlString = [NSString stringWithFormat:@"http://itunes.apple.com/search?term=%@", escapedSearchText];
    NSURL *url = [NSURL URLWithString:urlString];
    return url;
}

- (NSString *)performStoreRequestWithURL:(NSURL *)url
{
    NSError *error;
    NSString *resultString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    if (resultString == nil) {
        NSLog(@"Download Error: %@", error);
        return  nil;
    }
    return resultString;
}

- (NSDictionary *)parseJSON:(NSString *)jsonString
{
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    id resultObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (resultObject == nil) {
        NSLog(@"JSON Error: %@", error);
        return nil;
    }
    
    return resultObject;
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar
{
    return UIBarPositionTopAttached;
}

@end
