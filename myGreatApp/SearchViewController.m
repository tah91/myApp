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
#import "DetailCell.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize tableView;
@synthesize searchBar;
@synthesize previousSearch;

- (void)viewDidLoad
{
    [self.tableView registerNib:[UINib nibWithNibName:kDetailCellIdent bundle:nil] forCellReuseIdentifier:kDetailCellIdent];
    
    [super viewDidLoad];
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSData* previousSearchData = [defaults objectForKey:kSearchKey];
    if (previousSearchData != nil)
    {
        NSArray* oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:previousSearchData];
        if (oldSavedArray != nil)
            self.previousSearch = [[NSMutableArray alloc] initWithArray:oldSavedArray];
        else
            self.previousSearch = [[NSMutableArray alloc] init];
    }
    else {
        self.previousSearch = [[NSMutableArray alloc] init];
    }
    
    self.navigationItem.title = NSLocalizedString(@"Près d'un lieu",nil);
}

- (void)viewDidUnload
{
    [self setSearchBar:nil];
    [self setTableView:nil];
    self.previousSearch = nil;
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
    return [self.previousSearch count];
}

- (UITableViewCell *)tableView:(UITableView *)tableViewVal cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCell* cell = (DetailCell *)[tableViewVal dequeueReusableCellWithIdentifier:kDetailCellIdent];
    [cell setLabel:[self.previousSearch objectAtIndex:indexPath.row] withSegue:@"previousSearchSegue" andController:self];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
        DetailCell* cell = (DetailCell*)[self tableView:self.tableView cellForRowAtIndexPath:selectedIndex];
        
        SearchCriteria* criteria = [[SearchCriteria alloc] initWithPlace:cell.titleLabel.text];
        [ss setCriteria:criteria];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar
{
    if(![self.previousSearch containsObject:searchBar.text])
        [self.previousSearch insertObject:searchBar.text atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:self.previousSearch] forKey:kSearchKey];
    
    [self performSegueWithIdentifier:@"previousSearchSegue" sender:theSearchBar];
}

@end
