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

@synthesize radiusTypes,checkedIndexPath,radiusArray;
@synthesize applySearchDelegate,criteria;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    radiusTypes = [[NSDictionary alloc] initWithObjectsAndKeys:
                    [NSNumber numberWithInt:1],@"1 km",
                    [NSNumber numberWithInt:2],@"2 km",
                    [NSNumber numberWithInt:5],@"5 km",
                    [NSNumber numberWithInt:10],@"10 km",
                    [NSNumber numberWithInt:20],@"20 km",
                    [NSNumber numberWithInt:50],@"50 km",
                    nil];
    
    radiusArray = [radiusTypes keysSortedByValueUsingSelector:@selector(compare:)];
    
    NSString* selectedRadius = [[radiusTypes allKeysForObject:criteria.boundary] objectAtIndex:0];
    NSUInteger index = [radiusArray indexOfObject:selectedRadius];
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
    return [radiusArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCell* cell = [tableView dequeueReusableCellWithIdentifier:@"radiusCell"];
    
    cell.titleLabel.text = [radiusArray objectAtIndex:indexPath.row];
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
        UITableViewCell* uncheckCell = [tableView cellForRowAtIndexPath:self.checkedIndexPath];
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
    NSNumber* radius = [radiusTypes objectForKey:[radiusArray objectAtIndex:checkedIndexPath.row]];
    [criteria setBoundary:radius];
    [applySearchDelegate confirmWithCriteria:criteria];
}

@end
