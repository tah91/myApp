//
//  ResultViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 09/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ResultViewController.h"
#import "DetailViewController.h"
#import "ResultItemCell.h"
#import "Localisation.h"
#import "AppDelegate.h"
#import "LocalisationAnnotation.h"
#import "ControllerHelper.h"

@interface ResultViewController ()

@end

@implementation ResultViewController
@synthesize mapView;
@synthesize tableView;

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
    
    [ApplicationDelegate.localisationEngine searchWithCriteria:criteria
                                                  onCompletion:^(NSMutableArray* localisations) {
                                                      [self reloadData:localisations];
                                                  }
                                                       onError:^(NSError* error) {
                                                           ALERT_TITLE(@"Erreur",[error localizedDescription])
                                                       }];
    
    self.navigationItem.title = criteria.place;
    
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:criteria.place
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     CLPlacemark* found = [placemarks objectAtIndex:0];
                     MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(found.location.coordinate, 30000, 30000);
                     MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];                
                     [mapView setRegion:adjustedRegion animated:YES];
                 }];
          
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    
    UIView *containerView = [[UIView alloc] initWithFrame:frame];
    //containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view = containerView;
    frame = self.view.bounds;
    [self.view addSubview:tableView];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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
    ResultItemCell* cell = (ResultItemCell *)[tableViewVal dequeueReusableCellWithIdentifier:@"placeItem"];
    Localisation* loc = [results objectAtIndex:indexPath.row];
	cell.nameLabel.text = loc.name;
	cell.cityLabel.text = loc.city;
    cell.locId = loc.id;
    return cell;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"detailSegue"]) {
        NSIndexPath* selectedIndex = [self.tableView indexPathForSelectedRow];
        ResultItemCell* cell = (ResultItemCell*)[self tableView:self.tableView cellForRowAtIndexPath:selectedIndex];
        
        DetailViewController *ds = [segue destinationViewController];
        [ds setLocId:cell.locId];
    }
    else if ([[segue identifier] isEqualToString:@"annotationDetailSegue"]) {
        DetailViewController *dvc = [segue destinationViewController];
        LocalisationAnnotation* annotation = (LocalisationAnnotation*)sender;
        [dvc setLocId:annotation.locId];
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
