//
//  ViewControllerAddTrip.m
//  ShoesAt
//
//  Created by Bogdan Tudor on 11/03/15.
//  Copyright (c) 2015 Bogdan Tudor. All rights reserved.
//

#import "ViewControllerAddTrip.h"


@implementation ViewControllerAddTrip {
    NSMutableArray *youArray;
}

@synthesize searchBar;
@synthesize yourTable;
@synthesize tableData;
@synthesize searchResult;


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableData = @[@"One",@"Two",@"Three",@"Twenty-one"];
    self.searchResult = [NSMutableArray arrayWithCapacity:[self.tableData count]];
    self.yourTable.hidden = YES;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    self.yourTable.hidden = NO;
    [self.searchResult removeAllObjects];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
    
    self.searchResult = [NSMutableArray arrayWithArray: [self.tableData filteredArrayUsingPredicate:resultPredicate]];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    self.yourTable.hidden = NO;
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.searchResult count];
    }
    else
    {
        return [self.tableData count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        cell.textLabel.text = [self.searchResult objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text = self.tableData[indexPath.row];
    }
    
    return cell;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.yourTable.hidden = YES;
}

- (IBAction)goBackToProfile:(id)sender {
      [self performSegueWithIdentifier:@"backToProfile" sender:self];
}


@end
