//
//  SearchViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"
#import "SelectSearchViewController.h"
#import "SearchCriteria.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize tableView;
@synthesize searchBar;
@synthesize previousSeach;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSData* previousSearchData = [defaults objectForKey:@"previousSearch"];
    if (previousSearchData != nil)
    {
        NSArray* oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:previousSearchData];
        if (oldSavedArray != nil)
            previousSeach = [[NSMutableArray alloc] initWithArray:oldSavedArray];
        else
            previousSeach = [[NSMutableArray alloc] init];
    }
    else {
        previousSeach = [[NSMutableArray alloc] init];
    }
}

- (void)viewDidUnload
{
    [self setSearchBar:nil];
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [previousSeach count];
}

- (UITableViewCell *)tableView:(UITableView *)tableViewVal cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = (UITableViewCell *)[tableViewVal dequeueReusableCellWithIdentifier:@"searchItem"];
    NSString* text = [previousSeach objectAtIndex:indexPath.row];
	cell.textLabel.text = text;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"searchBarSegue"]) {
        
        SelectSearchViewController* ss = [segue destinationViewController];
        
        SearchCriteria* criteria = [[SearchCriteria alloc] initWithPlace:searchBar.text];
        [ss setCriteria:criteria];
    } else if ([[segue identifier] isEqualToString:@"previousSearchSegue"]) {
        SelectSearchViewController* ss = [segue destinationViewController];
        NSIndexPath* selectedIndex = [self.tableView indexPathForSelectedRow];
        UITableViewCell* cell = [self tableView:self.tableView cellForRowAtIndexPath:selectedIndex];
        
        SearchCriteria* criteria = [[SearchCriteria alloc] initWithPlace:cell.textLabel.text];
        [ss setCriteria:criteria];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar
{
    if(![previousSeach containsObject:searchBar.text])
        [previousSeach insertObject:searchBar.text atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:previousSeach] forKey:@"previousSearch"];
    
    [self performSegueWithIdentifier:@"searchBarSegue" sender:theSearchBar];
}

@end
