//
//  SearchByNameViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 28/08/12.
//
//

#import "SearchByNameViewController.h"
#import "SelectSearchViewController.h"
#import "SearchCriteria.h"
#import "DetailCell.h"

@interface SearchByNameViewController ()

@end

@implementation SearchByNameViewController

@synthesize tableView;
@synthesize searchBar;
@synthesize previousSearch;

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
    [self.tableView registerNib:[UINib nibWithNibName:kDetailCellIdent bundle:nil] forCellReuseIdentifier:kDetailCellIdent];
    
    [super viewDidLoad];
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSData* previousSearchData = [defaults objectForKey:kSearchByNameKey];
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
    
    self.tableView.backgroundColor = BNG_PATTERN;
    self.navigationItem.title = NSLocalizedString(@"Par nom du lieu",nil);
}

- (void)viewDidUnload
{
    [self setSearchBar:nil];
    [self setTableView:nil];
    self.previousSearch = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    [cell setLabel:[self.previousSearch objectAtIndex:indexPath.row] withSegue:@"previousSearchByNameSegue" andController:self];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"searchByNameBarSegue"]) {
        
        SelectSearchViewController* ss = [segue destinationViewController];
        
        SearchCriteria* criteria = [[SearchCriteria alloc] initWithName:searchBar.text];
        [ss setCriteria:criteria];
    } else if ([[segue identifier] isEqualToString:@"previousSearchByNameSegue"]) {
        SelectSearchViewController* ss = [segue destinationViewController];
        NSIndexPath* selectedIndex = [self.tableView indexPathForSelectedRow];
        DetailCell* cell = (DetailCell*)[self tableView:self.tableView cellForRowAtIndexPath:selectedIndex];
        
        SearchCriteria* criteria = [[SearchCriteria alloc] initWithName:cell.titleLabel.text];
        [ss setCriteria:criteria];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar
{
    if(![self.previousSearch containsObject:searchBar.text])
        [self.previousSearch insertObject:searchBar.text atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:self.previousSearch] forKey:kSearchByNameKey];
    
    [self performSegueWithIdentifier:@"searchByNameBarSegue" sender:theSearchBar];
}

@end
