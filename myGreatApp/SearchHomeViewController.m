//
//  SearchHomeViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 28/08/12.
//
//

#import "SearchHomeViewController.h"
#import "DetailCell.h"
#import "SelectSearchViewController.h"
#import "SearchCriteria.h"

@interface SearchHomeViewController ()

@end

@implementation SearchHomeViewController

@synthesize tableView,locationManager,latitude,longitude;

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
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    self.navigationItem.title = NSLocalizedString(@"Rechercher",nil);
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"nearHereSegue"]) {
        
        SelectSearchViewController* ss = [segue destinationViewController];
        
        SearchCriteria* criteria = [[SearchCriteria alloc] initWithLatitude:self.latitude andLongitude:self.longitude];
        [ss setCriteria:criteria];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableViewVal numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableViewVal cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCell* cell = [tableViewVal dequeueReusableCellWithIdentifier:kDetailCellIdent];
    
    switch (indexPath.row) {
        case 0:
            [cell setLabel:NSLocalizedString(@"Près de ma position",nil) withSegue:@"nearHereSegue" andController:self];
            break;
        case 1:
            [cell setLabel:NSLocalizedString(@"Rechercher à proximité d'un lieu",nil) withSegue:@"byPlaceSegue" andController:self];
            break;
        case 2:
            [cell setLabel:NSLocalizedString(@"Rechercher par nom du lieu",nil) withSegue:@"byNameSegue" andController:self];
            break;
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableViewVal didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - CLLocationManager Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    self.latitude = [NSNumber numberWithDouble:newLocation.coordinate.latitude];
    self.longitude = [NSNumber numberWithDouble:newLocation.coordinate.longitude];
    
}

@end
