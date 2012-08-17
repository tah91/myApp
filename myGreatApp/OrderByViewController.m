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

@synthesize orderByTypes,checkedIndexPath,orderByArray;
@synthesize applySearchDelegate,criteria;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    orderByTypes = [[NSDictionary alloc] initWithObjectsAndKeys:
                    [NSNumber numberWithInt:ob_rating],@"Note",
                    [NSNumber numberWithInt:ob_distance],@"Distance",
                    nil];
    
    orderByArray = [orderByTypes keysSortedByValueUsingSelector:@selector(compare:)];
    
    NSString* selectedOrder = [[orderByTypes allKeysForObject:[NSNumber numberWithInt:criteria.orderBy]] objectAtIndex:0];
    NSUInteger index = [orderByArray indexOfObject:selectedOrder];
    checkedIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
}

- (void)viewDidUnload
{
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
    return [orderByArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCell* cell = [tableView dequeueReusableCellWithIdentifier:@"orderByCell"];
    
    cell.titleLabel.text = [orderByArray objectAtIndex:indexPath.row];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Uncheck the previous checked row
    if(self.checkedIndexPath)
    {
        UITableViewCell* uncheckCell = [tableView
                                        cellForRowAtIndexPath:self.checkedIndexPath];
        uncheckCell.accessoryType = UITableViewCellAccessoryNone;
    }
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.checkedIndexPath = indexPath;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)cancel:(id)sender {
    [applySearchDelegate cancel];
}

- (IBAction)confirm:(id)sender {
    NSNumber* order = [orderByTypes objectForKey:[orderByArray objectAtIndex:checkedIndexPath.row]];
    [criteria setOrderBy:order.intValue];
    [applySearchDelegate confirmWithCriteria:criteria];
}

@end
