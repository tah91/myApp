//
//  OrderByViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 28/07/12.
//
//

#import "OrderByViewController.h"
#import "DetailCell.h"

@interface OrderByViewController ()

@end

@implementation OrderByViewController
@synthesize bar;

@synthesize tableView,orderByTypes,checkedIndexPath,orderByArray;
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

    orderByTypes = [[NSDictionary alloc] initWithObjectsAndKeys:
                    [NSNumber numberWithInt:ob_rating],NSLocalizedString(@"Note",nil),
                    [NSNumber numberWithInt:ob_distance],NSLocalizedString(@"Distance",nil),
                    nil];
    
    orderByArray = [orderByTypes keysSortedByValueUsingSelector:@selector(compare:)];
    
    NSString* selectedOrder = [[orderByTypes allKeysForObject:[NSNumber numberWithInt:criteria.orderBy]] objectAtIndex:0];
    NSUInteger index = [orderByArray indexOfObject:selectedOrder];
    checkedIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    self.bar.topItem.title = NSLocalizedString(@"Trier",nil);
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

- (NSInteger)tableView:(UITableView *)tableViewVal numberOfRowsInSection:(NSInteger)section
{
    return [orderByArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableViewVal cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCell* cell = [tableViewVal dequeueReusableCellWithIdentifier:kDetailCellIdent];
    
    [cell setLabel:[orderByArray objectAtIndex:indexPath.row] withSegue:nil andController:nil];
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
    NSNumber* order = [orderByTypes objectForKey:[orderByArray objectAtIndex:checkedIndexPath.row]];
    [criteria setOrderBy:order.intValue];
    [applySearchDelegate confirmWithCriteria:criteria];
}

@end
