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
@synthesize bar;
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
    [self.locTypesTableView registerNib:[UINib nibWithNibName:kDetailCellIdent bundle:nil] forCellReuseIdentifier:kDetailCellIdent];
    [self.featuresTableView registerNib:[UINib nibWithNibName:kDetailCellIdent bundle:nil] forCellReuseIdentifier:kDetailCellIdent];
    
    [super viewDidLoad];
    
    self.locTypes = [[NSDictionary alloc] initWithObjectsAndKeys:
                     [NSNumber numberWithInt:-1],NSLocalizedString(@"Tous les types",nil),
                     [NSNumber numberWithInt:lt_wifiHotspot],NSLocalizedString(@"wifiHotspot",nil),
                     [NSNumber numberWithInt:lt_cafeRestaurant],NSLocalizedString(@"cafeRestaurant",nil),
                     [NSNumber numberWithInt:lt_librairyMuseum],NSLocalizedString(@"librairyMuseum",nil),
                     [NSNumber numberWithInt:lt_internetCafe],NSLocalizedString(@"internetCafe",nil),
                     [NSNumber numberWithInt:lt_travelerLounge],NSLocalizedString(@"travelerLounge",nil),
                     [NSNumber numberWithInt:lt_hotel],NSLocalizedString(@"hotel",nil),
                     [NSNumber numberWithInt:lt_telecentre],NSLocalizedString(@"telecentre",nil),
                     [NSNumber numberWithInt:lt_businessLounge],NSLocalizedString(@"businessLounge",nil),
                     [NSNumber numberWithInt:lt_coworkingSpace],NSLocalizedString(@"coworkingSpace",nil),
                     [NSNumber numberWithInt:lt_corporateCentre],NSLocalizedString(@"corporateCentre",nil),
                     [NSNumber numberWithInt:lt_privatePlace],NSLocalizedString(@"privatePlace",nil),
                     [NSNumber numberWithInt:lt_sharedOffice],NSLocalizedString(@"sharedOffice",nil),
                     nil];
    
    self.locArray = [locTypes keysSortedByValueUsingSelector:@selector(compare:)];
    
    self.featureTypes = [[NSDictionary alloc] initWithObjectsAndKeys:
                         [NSNumber numberWithInt:-1],NSLocalizedString(@"Tous les services",nil),
                         [NSNumber numberWithInt:f_wifi_Free],NSLocalizedString(@"wifi",nil),
                         [NSNumber numberWithInt:f_coffee],NSLocalizedString(@"coffee",nil),
                         [NSNumber numberWithInt:f_restauration],NSLocalizedString(@"resto",nil),
                         [NSNumber numberWithInt:f_parking],NSLocalizedString(@"parking",nil),
                         [NSNumber numberWithInt:f_handicap],NSLocalizedString(@"handicap",nil),
                         nil];
    
    self.featureArray = [featureTypes keysSortedByValueUsingSelector:@selector(compare:)];
    
    [self.featuresTableView removeFromSuperview];
    
    self.selectedLoc = [self setFromString:criteria.types keys:locTypes andArray:locArray];
    self.selectedFeatures = [self setFromString:criteria.features keys:featureTypes andArray:featureArray];
    
    self.bar.topItem.title = NSLocalizedString(@"Critères",nil);
    [self.tabSelector setTitle:NSLocalizedString(@"Type",nil) forSegmentAtIndex:0];
    [self.tabSelector setTitle:NSLocalizedString(@"Services",nil) forSegmentAtIndex:1];
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
    [self setBar:nil];
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
        DetailCell* cell = [tableView dequeueReusableCellWithIdentifier:kDetailCellIdent];
        
        [cell setLabel:[locArray objectAtIndex:indexPath.row] withSegue:nil andController:nil];
        cell.accessoryType = UITableViewCellAccessoryNone;
        if([selectedLoc containsObject:indexPath] || (indexPath.row == 0 && indexPath.section == 0 && [selectedLoc count] == 0)) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
        return cell;
    }
    else if(tableView == featuresTableView) {
        DetailCell* cell = [tableView dequeueReusableCellWithIdentifier:kDetailCellIdent];
        
        [cell setLabel:[featureArray objectAtIndex:indexPath.row] withSegue:nil andController:nil];
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

- (IBAction)tabChanged:(id)sender
{
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

- (IBAction)cancel:(id)sender
{
    [applySearchDelegate cancel];
}

- (IBAction)confirm:(id)sender
{
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
