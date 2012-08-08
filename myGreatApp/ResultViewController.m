//
//  ResultViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 09/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ResultViewController.h"
#import "DetailViewController.h"
#import "LocalisationCell.h"
#import "Localisation.h"
#import "AppDelegate.h"
#import "LocalisationAnnotation.h"
#import "ControllerHelper.h"
#import "OrderByViewController.h"
#import "SelectRadiusViewController.h"
#import "SelectTypeViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController
@synthesize mapView;
@synthesize tableView;
@synthesize activityView;
@synthesize toolsView;
@synthesize loadingLabel;
@synthesize orderByBtn;
@synthesize criteriaBtn;
@synthesize radiusBtn;

@synthesize results, criteria;


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
	// Do any additional setup after loading the view.
    
    [self fetchData];
          
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    
    UIView *containerView = [[UIView alloc] initWithFrame:frame];
    //containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view = containerView;
    frame = self.view.bounds;
    [self.view addSubview:tableView];
    [self.view addSubview:toolsView];
    
    loadingLabel.text = @"Chargement";
    
    UIImage *toolsBng = [[UIImage imageNamed:@"tools-btn-bng.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [orderByBtn setBackgroundImage:toolsBng forState:UIControlStateNormal];
    UIImage *orderByLogo = [UIImage imageNamed:@"tool-orderby-logo.png"];
    //[orderByBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 10.0, 0.0, 0.0)];
    [orderByBtn setImage:orderByLogo forState:UIControlStateNormal];
    [orderByBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 10.0)];
    
    UIImage *criteriaLogo = [UIImage imageNamed:@"tool-criteria-logo.png"];
    [criteriaBtn setBackgroundImage:toolsBng forState:UIControlStateNormal];
    [criteriaBtn setImage:criteriaLogo forState:UIControlStateNormal];
    [criteriaBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 10.0)];
    
    UIImage *radiusLogo = [UIImage imageNamed:@"tool-radius-logo.png"];
    [radiusBtn setBackgroundImage:toolsBng forState:UIControlStateNormal];
    [radiusBtn setImage:radiusLogo forState:UIControlStateNormal];
    [radiusBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 10.0)];

}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setMapView:nil];
    [self setActivityView:nil];
    [self setToolsView:nil];
    [self setLoadingLabel:nil];
    [self setOrderByBtn:nil];
    [self setCriteriaBtn:nil];
    [self setRadiusBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) fetchData {
    [ApplicationDelegate.localisationEngine searchWithCriteria:criteria
                                                  onCompletion:^(NSMutableArray* localisations) {
                                                      [self reloadData:localisations];
                                                  }
                                                       onError:^(NSError* error) {
                                                           ALERT_TITLE(@"Erreur",[error localizedDescription])
                                                       }];
    
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:criteria.place
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     CLPlacemark* found = [placemarks objectAtIndex:0];
                     MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(found.location.coordinate, 30000, 30000);
                     MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
                     [mapView setRegion:adjustedRegion animated:YES];
                 }];
}

- (void)reloadData:(NSMutableArray*) localisations
{
    results = [NSMutableArray arrayWithCapacity:20];
    
    for (NSDictionary* jsonObject in localisations) {
        Localisation* loc = [[Localisation alloc] initWithDictionary:jsonObject];
        [results addObject:loc];
    }
    
    [self.tableView reloadData]; 
    
    for(Localisation* loc in results) {
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [loc.latitude doubleValue];
        coordinate.longitude = [loc.longitude doubleValue];
        LocalisationAnnotation* toAdd = [[LocalisationAnnotation alloc] initWithName:loc.name address:loc.city coordinate:coordinate locId:loc.id];
        [mapView addAnnotation:toAdd];
    }
    
    self.navigationItem.title = criteria.place;
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
    return [results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableViewVal cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Localisation* loc = [results objectAtIndex:indexPath.row];
    NSString* identifier = loc.isFree ? @"freeLocCell" : @"payingLocCell";
    LocalisationCell* cell = (LocalisationCell*)[tableViewVal dequeueReusableCellWithIdentifier:identifier];
    [cell setFieldsFromLoc:loc];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"%d résultats trouvés",[results count]];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (UIView *) tableView:(UITableView *)theTableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theTableView.bounds.size.width, 26)];
    [headerView setBackgroundColor:[UIColor blackColor]];
    
    UILabel* headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:10];
    headerLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    headerLabel.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    headerLabel.frame = CGRectMake(11,-11, 320.0, 44.0);
    headerLabel.textAlignment = UITextAlignmentLeft;
    headerLabel.text = [self tableView:theTableView titleForHeaderInSection:section];
    [headerView addSubview:headerLabel];
    
    return headerView;
}

#pragma mark - Map View Delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
	MKPinAnnotationView *annView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
    [annView setCanShowCallout:YES];
    [annView setSelected:YES];
    [annView setUserInteractionEnabled: YES];
    
    annView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annView;
}

- (void)mapView:(MKMapView *)mv annotationView:(MKAnnotationView *)pin calloutAccessoryControlTapped:(UIControl *)control {	
    [self performSegueWithIdentifier:@"annotationDetailSegue" sender:pin.annotation];
}

#pragma mark - Apply Seach Delegate

-(void)cancel {
    [self dismissModalViewControllerAnimated:YES];
}

-(void)confirmWithCriteria:(SearchCriteria*)newCriteria {
    [self dismissModalViewControllerAnimated:YES];
    [self setCriteria:newCriteria];
    [self fetchData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"freeDetailSegue"]) {
        NSIndexPath* selectedIndex = [self.tableView indexPathForSelectedRow];
        LocalisationCell* cell = (LocalisationCell*)[self tableView:self.tableView cellForRowAtIndexPath:selectedIndex];
        
        DetailViewController *ds = [segue destinationViewController];
        [ds setLocId:cell.locId];
    }
    else if ([[segue identifier] isEqualToString:@"detailSegue"]) {
        NSIndexPath* selectedIndex = [self.tableView indexPathForSelectedRow];
        LocalisationCell* cell = (LocalisationCell*)[self tableView:self.tableView cellForRowAtIndexPath:selectedIndex];
        
        DetailViewController *ds = [segue destinationViewController];
        [ds setLocId:cell.locId];
    }
    else if ([[segue identifier] isEqualToString:@"annotationDetailSegue"]) {
        DetailViewController *dvc = [segue destinationViewController];
        LocalisationAnnotation* annotation = (LocalisationAnnotation*)sender;
        [dvc setLocId:annotation.locId];
    }
    else if ([[segue identifier] isEqualToString:@"orderBySegue"]) {
        OrderByViewController *ovc = [segue destinationViewController];
        ovc.applySearchDelegate = self;
        ovc.criteria = criteria;
    }
    else if ([[segue identifier] isEqualToString:@"radiusSegue"]) {
        SelectRadiusViewController *srvc = [segue destinationViewController];
        srvc.applySearchDelegate = self;
        srvc.criteria = criteria;
    }
    else if ([[segue identifier] isEqualToString:@"selectTypeSegue"]) {
        SelectTypeViewController *stvc = [segue destinationViewController];
        stvc.applySearchDelegate = self;
        stvc.criteria = criteria;
    }
}

- (IBAction)switchView:(id)sender {
    self.mapView.frame = self.tableView.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    if([self.tableView superview]) {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
        [self.tableView removeFromSuperview];
        [self.view addSubview:self.mapView];
    } else if([self.mapView superview]){
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        [self.mapView removeFromSuperview];
        [self.view addSubview:self.tableView];
    }
    
    [UIView commitAnimations];
}

@end
