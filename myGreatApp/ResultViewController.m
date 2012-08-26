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
#import "OrderByViewController.h"
#import "SelectRadiusViewController.h"
#import "SelectTypeViewController.h"
#import "UIView+TIAdditions.h"

@interface ResultViewController ()

@end

@implementation ResultViewController
@synthesize loadingLabel;
@synthesize loadingView;
@synthesize mapView;
@synthesize mapViewHelp;
@synthesize mapViewActivity;
@synthesize mapViewHelpLabel;
@synthesize tableView;
@synthesize toolsView;
@synthesize orderByBtn;
@synthesize criteriaBtn;
@synthesize radiusBtn;

@synthesize results, criteria, maxCount, isFetching, center, fetchedLocalisations, fromCode, ne, sw;


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
          
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    
    UIView *containerView = [[UIView alloc] initWithFrame:frame];
    self.view = containerView;
    frame = self.view.bounds;
    [self.view addSubview:tableView];
    [self.view addSubview:toolsView];
    
    UIImage *toolsBng = [[UIImage imageNamed:@"tools-btn-bng.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [orderByBtn setBackgroundImage:toolsBng forState:UIControlStateNormal];
    UIImage *orderByLogo = [UIImage imageNamed:@"tool-orderby-logo.png"];
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
    
    self.results = [NSMutableArray arrayWithCapacity:20];
    self.isFetching = false;
    self.fromCode = false;
    self.loadingLabel.text = @"Chargment des lieux...";
    self.mapViewHelpLabel.text = @"Chargement...";
    [self fetchData:false];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setMapView:nil];
    [self setToolsView:nil];
    [self setOrderByBtn:nil];
    [self setCriteriaBtn:nil];
    [self setRadiusBtn:nil];
    [self setLoadingLabel:nil];
    [self setLoadingView:nil];
    [self setMapViewHelp:nil];
    [self setMapViewActivity:nil];
    [self setMapViewHelpLabel:nil];
    
    self.results = nil;
    self.maxCount = nil;
    self.fetchedLocalisations = nil;
    self.criteria = nil;
    [super viewDidUnload];
}

- (void) fetchData:(BOOL)clearPrevious
{
    self.isFetching = true;
    
    [self.mapViewActivity startAnimating];
    self.mapViewHelpLabel.text = @"Chargement...";
    
    [ApplicationDelegate.localisationEngine enqueueOperationWithUrl:SEARCH_URL
                                                             params:[criteria getParams]
                                                         httpMethod:@"GET"
                                                       onCompletion:^(NSObject* json) {
                                                           [self parseData:json];
                                                           [self refreshData:clearPrevious];
                                                           self.isFetching = false;
                                                       }
                                                            onError:^(NSError* error) {
                                                                ALERT_TITLE(@"Erreur",[error localizedDescription])
                                                                self.isFetching = false;
                                                            }];
}

- (void)parseData:(NSObject*)json
{
    NSMutableDictionary* localisationsContainer = (NSMutableDictionary*)json;
    self.fetchedLocalisations = [localisationsContainer objectForKey:@"list"];
    self.maxCount = [localisationsContainer objectForKey:@"maxCount"];
    NSNumber* lat = [localisationsContainer objectForKey:@"latitude"];
    NSNumber* lng = [localisationsContainer objectForKey:@"longitude"];
    center.latitude = lat.doubleValue;
    center.longitude = lng.doubleValue;
}

- (MKCoordinateRegion)getRegion
{
    CLLocationDistance lngMeters, latMeters;
    
    //no bounds => get criteria boundary
    if(ne.latitude == 0 || ne.longitude == 0 || sw.longitude == 0 || sw.longitude == 0) {
        lngMeters = self.criteria.boundary.doubleValue * 1.5 * 1000;
        latMeters = self.criteria.boundary.doubleValue * 1.5 * 1000;
    }
    else {
        CLLocation * neLoc = [[CLLocation alloc] initWithLatitude:ne.latitude
                                                        longitude:ne.longitude];
        CLLocation * nwLoc = [[CLLocation alloc] initWithLatitude:ne.latitude
                                                        longitude:sw.longitude];
        CLLocation * swLoc = [[CLLocation alloc] initWithLatitude:sw.latitude
                                                        longitude:sw.longitude];
        CLLocation * seLoc = [[CLLocation alloc] initWithLatitude:sw.latitude
                                                        longitude:ne.longitude];
        
        lngMeters = [neLoc distanceFromLocation:nwLoc];
        latMeters = [swLoc distanceFromLocation:seLoc];
    }
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(center, latMeters, lngMeters);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    return adjustedRegion;
}

- (void)refreshData:(BOOL)clearPrevious
{
    if(clearPrevious) {
        self.results = [NSMutableArray arrayWithCapacity:20];
        NSArray* annotations = [self.mapView annotations];
        [self.mapView removeAnnotations:annotations];
    }
    
    for (NSDictionary* jsonObject in fetchedLocalisations) {
        Localisation* loc = [[Localisation alloc] initWithDictionary:jsonObject];
        [self.results addObject:loc];
    }
    
    for(Localisation* loc in self.results) {
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [loc.latitude doubleValue];
        coordinate.longitude = [loc.longitude doubleValue];
        LocalisationAnnotation* toAdd = [[LocalisationAnnotation alloc] initWithName:loc.name address:loc.city coordinate:coordinate localisation:loc];
        [self.mapView addAnnotation:toAdd];
    }
    
    self.fromCode = true;
    [self.mapView setRegion:[self getRegion] animated:YES];
    
    self.navigationItem.title = criteria.place;
    
    [self.tableView reloadData];
    if([self.results count] >= maxCount.intValue) {
        [self.loadingView removeAndHide];
    }
    
    [self.mapViewActivity stopAnimating];
    if([self.results count] >= maxCount.intValue) {
        self.mapViewHelpLabel.text = [NSString stringWithFormat:@"%u lieux trouvés",[results count]];
    }
    else {
        self.mapViewHelpLabel.text = [NSString stringWithFormat:@"Zoomer pour voir %@ lieux",maxCount];
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
    return [self.results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableViewVal cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Localisation* loc = [results objectAtIndex:indexPath.row];
    NSString* identifier = loc.isFree ? @"freeLocCell" : @"payingLocCell";
    LocalisationCell* cell = (LocalisationCell*)[tableViewVal dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil) {
        cell = [[LocalisationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setFieldsFromLoc:loc];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"%u résultats sur %@", [self.results count], self.maxCount];
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
    if([self.results count] == 0) {
        return [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theTableView.bounds.size.width, 26)];
    [headerView setBackgroundColor:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0]];
    
    UILabel* headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:10];
    headerLabel.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    headerLabel.frame = CGRectMake(11,-11, 320.0, 44.0);
    headerLabel.textAlignment = UITextAlignmentLeft;
    headerLabel.text = [self tableView:theTableView titleForHeaderInSection:section];
    [headerView addSubview:headerLabel];
    
    return headerView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.isFetching) {
        return;
    }
    
    bool isVisible = CGRectIntersectsRect(scrollView.bounds, self.loadingView.frame);
    if(isVisible) {
        self.criteria.page++;
        NSInteger currentCount = [results count];
        NSInteger expectedCount = kResultPerPage * criteria.page;
        if(currentCount < expectedCount) {
            [self fetchData:false];
        }
    }
}

#pragma mark - Map View Delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	MKPinAnnotationView *annView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
    [annView setCanShowCallout:YES];
    [annView setSelected:YES];
    [annView setUserInteractionEnabled: YES];
    
    annView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annView;
}

- (void)mapView:(MKMapView *)mv annotationView:(MKAnnotationView *)pin calloutAccessoryControlTapped:(UIControl *)control
{
    [self performSegueWithIdentifier:@"annotationDetailSegue" sender:pin.annotation];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if(self.fromCode) {
        self.fromCode = false;
        return;
    }
    
    if(self.isFetching) {
        return;
    }
    
    MKCoordinateRegion region = [self.mapView region];
    ne.latitude = region.center.latitude + region.span.latitudeDelta / 2;
    ne.longitude = region.center.longitude + region.span.longitudeDelta / 2;
    sw.latitude = region.center.latitude - region.span.latitudeDelta / 2;
    sw.longitude = region.center.longitude - region.span.longitudeDelta / 2;
    
    criteria.neLat = [NSNumber numberWithDouble:ne.latitude];
    criteria.neLng = [NSNumber numberWithDouble:ne.longitude];
    criteria.swLat = [NSNumber numberWithDouble:sw.latitude];
    criteria.swLng = [NSNumber numberWithDouble:sw.longitude];
    
    [self fetchData:true];
}

#pragma mark - Apply Seach Delegate

-(void)cancel
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)confirmWithCriteria:(SearchCriteria*)newCriteria
{
    [self dismissModalViewControllerAnimated:YES];
    [self setCriteria:newCriteria];
    [self fetchData:true];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"freeDetailSegue"] || [[segue identifier] isEqualToString:@"payingDetailSegue"]) {
        NSIndexPath* selectedIndex = [self.tableView indexPathForSelectedRow];
        LocalisationCell* cell = (LocalisationCell*)[self tableView:self.tableView cellForRowAtIndexPath:selectedIndex];
        
        DetailViewController *ds = [segue destinationViewController];
        [ds setLocalisation:cell.localisation];
    }
    else if ([[segue identifier] isEqualToString:@"annotationDetailSegue"]) {
        DetailViewController *dvc = [segue destinationViewController];
        LocalisationAnnotation* annotation = (LocalisationAnnotation*)sender;
        [dvc setLocalisation:annotation.localisation];
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

- (IBAction)switchView:(id)sender
{
    self.mapView.frame = self.tableView.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    if([self.tableView superview]) {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
        [self.tableView removeFromSuperview];
        [self.view addSubview:self.mapView];
        [self.view addSubview:self.mapViewHelp];
    } else if([self.mapView superview]){
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        [self.mapView removeFromSuperview];
        [self.mapViewHelp removeFromSuperview];
        [self.view addSubview:self.tableView];
    }
    
    [UIView commitAnimations];
}

@end
