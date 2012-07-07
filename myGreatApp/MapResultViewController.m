//
//  MapResultViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 07/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapResultViewController.h"
#import "DetailViewController.h"
#import "Localisation.h"
#import "LocalisationAnnotation.h"

@interface MapResultViewController ()

@end

@implementation MapResultViewController
@synthesize mapView, searchPlace, results;

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
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:searchPlace
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     CLPlacemark* found = [placemarks objectAtIndex:0];
                     MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(found.location.coordinate, 30000, 30000);
                     MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];                
                     [mapView setRegion:adjustedRegion animated:YES];
                 }];
    
    for(Localisation* loc in results) {
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [loc.latitude doubleValue];
        coordinate.longitude = [loc.longitude doubleValue];
        LocalisationAnnotation* toAdd = [[LocalisationAnnotation alloc] initWithName:loc.name address:loc.city coordinate:coordinate locId:loc.id];
        [mapView addAnnotation:toAdd];
    }
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    if ([[segue identifier] isEqualToString:@"annotationDetailSegue"]) {
        DetailViewController *dvc = [segue destinationViewController];
        LocalisationAnnotation* annotation = (LocalisationAnnotation*)sender;
        [dvc setLocId:annotation.locId];
    }
}


@end
