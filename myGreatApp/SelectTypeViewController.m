//
//  SelectTypeViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 28/07/12.
//
//

#import "SelectTypeViewController.h"
#import "DetailCell.h"

@interface SelectTypeViewController ()

@end

@implementation SelectTypeViewController
@synthesize containerView;
@synthesize locTypesTableView;
@synthesize featuresTableView;
@synthesize tabSelector;

@synthesize locTypes,locArray,featureTypes,featureArray,applySearchDelegate,criteria,selectedLoc,selectedFeatures;

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
    
    locTypes = [[NSDictionary alloc] initWithObjectsAndKeys:
                [NSNumber numberWithInt:-1],@"Tous les types",
                [NSNumber numberWithInt:lt_wifiHotspot],@"wifiHotspot",
                [NSNumber numberWithInt:lt_cafeRestaurant],@"cafeRestaurant",
                [NSNumber numberWithInt:lt_librairyMuseum],@"librairyMuseum",
                [NSNumber numberWithInt:lt_internetCafe],@"internetCafe",
                [NSNumber numberWithInt:lt_travelerLounge],@"travelerLounge",
                [NSNumber numberWithInt:lt_hotel],@"hotel",
                [NSNumber numberWithInt:lt_telecentre],@"telecentre",
                [NSNumber numberWithInt:lt_businessLounge],@"businessLounge",
                [NSNumber numberWithInt:lt_coworkingSpace],@"coworkingSpace",
                [NSNumber numberWithInt:lt_corporateCentre],@"corporateCentre",
                [NSNumber numberWithInt:lt_privatePlace],@"privatePlace",
                [NSNumber numberWithInt:lt_sharedOffice],@"sharedOffice",
                nil];
    
    locArray = [locTypes keysSortedByValueUsingSelector:@selector(compare:)];
    
    featureTypes = [[NSDictionary alloc] initWithObjectsAndKeys:
                    [NSNumber numberWithInt:-1],@"Tous les services",
                    [NSNumber numberWithInt:f_wifi_Free],@"wifi",
                    [NSNumber numberWithInt:f_coffee],@"coffee",
                    [NSNumber numberWithInt:f_restauration],@"resto",
                    [NSNumber numberWithInt:f_parking],@"parking",
                    [NSNumber numberWithInt:f_handicap],@"handicap",
                    nil];
    
    featureArray = [featureTypes keysSortedByValueUsingSelector:@selector(compare:)];
    
    [featuresTableView removeFromSuperview];
    
    selectedLoc = [self setFromString:criteria.types keys:locTypes andArray:locArray];
    selectedFeatures = [self setFromString:criteria.features keys:featureTypes andArray:featureArray];
}

- (NSIndexPath*)getIndex:(NSInteger)intVal
                fromKeys:(NSDictionary*)keys
                andArray:(NSArray*)array{
    NSArray * founds = [keys allKeysForObject:[NSNumber numberWithInt:intVal]];
    if([founds count] == 0)
        return nil;
    NSString* lStr = [founds objectAtIndex:0];
    NSUInteger index = [array indexOfObject:lStr];
    return [NSIndexPath indexPathForRow:index inSection:0];
}

- (NSMutableSet*)setFromString:(NSString*)toParse
                          keys:(NSDictionary*)keys
                      andArray:(NSArray*)array {
    
    NSMutableSet* selected = [[NSMutableSet alloc] init];
    if([toParse length] > 2) {
        NSString* toSplit = [[toParse substringFromIndex:1] substringToIndex:[toParse length]-2];
        NSArray* chunks = [toSplit componentsSeparatedByString: @","];
        for (NSNumber* chunck in chunks) {
            NSIndexPath* index = [self getIndex:chunck.intValue fromKeys:keys andArray:array];
            if(index == nil)
                continue;
            [selected addObject:index];
        }
    }
        
    return selected;
}

- (void)viewDidUnload
{
    [self setContainerView:nil];
    [self setLocTypesTableView:nil];
    [self setFeaturesTableView:nil];
    [self setTabSelector:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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
    if(tableView == locTypesTableView) {
        return [locArray count];
    }
    else if(tableView == featuresTableView) {
        return [featureArray count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == locTypesTableView) {
        DetailCell* cell = [tableView dequeueReusableCellWithIdentifier:@"locTypeCell"];
        cell.titleLabel.text = [locArray objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryNone;
        if([selectedLoc containsObject:indexPath] || (indexPath.row == 0 && indexPath.section == 0 && [selectedLoc count] == 0)) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
        return cell;
    }
    else if(tableView == featuresTableView) {
        DetailCell* cell = [tableView dequeueReusableCellWithIdentifier:@"featureCell"];
        
        cell.titleLabel.text = [featureArray objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryNone;
        if([selectedFeatures containsObject:indexPath] || (indexPath.row == 0 && indexPath.section == 0 && [selectedFeatures count] == 0)) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        return cell;
    }
    
    return nil;
}

#pragma mark - Table view delegate

- (void)performSelectionOfTableView:(UITableView*)tableView
                        atIndexPath:(NSIndexPath*)indexPath
                           withKeys:(NSDictionary*)keys
                           selected:(NSMutableSet*)set
                           andArray:(NSArray*)array {
    NSNumber* type = [keys objectForKey:[array objectAtIndex:indexPath.row]];
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    //unselect all other cells
    if(type.intValue == -1) {
        [selectedCell setAccessoryType:UITableViewCellAccessoryCheckmark];
        for (NSIndexPath* indexToUnselect in selectedLoc) {
            UITableViewCell* toUnselect = [tableView cellForRowAtIndexPath:indexToUnselect];
            [toUnselect setAccessoryType:UITableViewCellAccessoryNone];
        }
        [set removeAllObjects];
    }
    else {
        UITableViewCell* toUnselect = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [toUnselect setAccessoryType:UITableViewCellAccessoryNone];
        if ([selectedCell accessoryType] == UITableViewCellAccessoryNone) {
            [selectedCell setAccessoryType:UITableViewCellAccessoryCheckmark];
            [set addObject:indexPath];
            
        }
        else {
            [selectedCell setAccessoryType:UITableViewCellAccessoryNone];
            [set removeObject:indexPath];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == locTypesTableView) {
        [self performSelectionOfTableView:tableView atIndexPath:indexPath withKeys:locTypes selected:selectedLoc andArray:locArray];
    }
    else if(tableView == featuresTableView) {
        [self performSelectionOfTableView:tableView atIndexPath:indexPath withKeys:featureTypes selected:selectedFeatures andArray:featureArray];
    }
}

- (IBAction)tabChanged:(id)sender {
    UISegmentedControl* seg = (UISegmentedControl*)sender;
    
    switch (seg.selectedSegmentIndex) {
        case 0:
            [featuresTableView removeFromSuperview];
            [containerView addSubview:locTypesTableView];
            break;
        case 1:
            [locTypesTableView removeFromSuperview];
            [containerView addSubview:featuresTableView];
            break;
        default:
            break;
    }
}

- (IBAction)cancel:(id)sender {
    [applySearchDelegate cancel];
}

- (IBAction)confirm:(id)sender {
    NSMutableArray* featuresToAdd = [NSMutableArray array];
    for(NSIndexPath* index in selectedFeatures) {
        [featuresToAdd addObject:[featureTypes objectForKey:[featureArray objectAtIndex:index.row]]];
    }
    [criteria setFeatures:[NSString stringWithFormat:@"[%@]",[featuresToAdd componentsJoinedByString:@","]]];
    
    NSMutableArray* locTypesToAdd = [NSMutableArray array];
    for(NSIndexPath* index in selectedLoc) {
        [locTypesToAdd addObject:[locTypes objectForKey:[locArray objectAtIndex:index.row]]];
    }
    [criteria setTypes:[NSString stringWithFormat:@"[%@]",[locTypesToAdd componentsJoinedByString:@","]]];
    [applySearchDelegate confirmWithCriteria:criteria];
}

@end
