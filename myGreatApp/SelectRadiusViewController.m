//
//  SelectRadiusViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 28/07/12.
//
//

#import "SelectRadiusViewController.h"
#import "DetailCell.h"

@interface SelectRadiusViewController ()

@end

@implementation SelectRadiusViewController
@synthesize bar;

@synthesize tableView,radiusTypes,checkedIndexPath,radiusArray;
@synthesize applySearchDelegate,criteria;

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

    self.tableView.backgroundColor = BNG_PATTERN;
    
    radiusTypes = [[NSDictionary alloc] initWithObjectsAndKeys:
                    [NSNumber numberWithInt:1],NSLocalizedString(@"1 km",nil),
                    [NSNumber numberWithInt:2],NSLocalizedString(@"2 km",nil),
                    [NSNumber numberWithInt:5],NSLocalizedString(@"5 km",nil),
                    [NSNumber numberWithInt:10],NSLocalizedString(@"10 km",nil),
                    [NSNumber numberWithInt:20],NSLocalizedString(@"20 km",nil),
                    [NSNumber numberWithInt:50],NSLocalizedString(@"50 km",nil),
                    nil];
    
    radiusArray = [radiusTypes keysSortedByValueUsingSelector:@selector(compare:)];
    
    NSString* selectedRadius = [[radiusTypes allKeysForObject:criteria.boundary] objectAtIndex:0];
    NSUInteger index = [radiusArray indexOfObject:selectedRadius];
    checkedIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    self.bar.topItem.title = NSLocalizedString(@"Rayon",nil);
}

- (void)viewDidUnload
{
    [self setBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    return [radiusArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableViewVal cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCell* cell = [tableViewVal dequeueReusableCellWithIdentifier:kDetailCellIdent];
    
    [cell setLabel:[radiusArray objectAtIndex:indexPath.row] withSegue:nil andController:nil];
    if([self.checkedIndexPath isEqual:indexPath])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableViewVal didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Uncheck the previous checked row
    if(self.checkedIndexPath)
    {
        UITableViewCell* uncheckCell = [tableViewVal cellForRowAtIndexPath:self.checkedIndexPath];
        uncheckCell.accessoryType = UITableViewCellAccessoryNone;
    }
    UITableViewCell* cell = [tableViewVal cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.checkedIndexPath = indexPath;
    
    [tableViewVal deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)cancel:(id)sender
{
    [applySearchDelegate cancel];
}

- (IBAction)confirm:(id)sender
{
    NSNumber* radius = [radiusTypes objectForKey:[radiusArray objectAtIndex:checkedIndexPath.row]];
    [criteria setBoundary:radius];
    [applySearchDelegate confirmWithCriteria:criteria];
}

@end
