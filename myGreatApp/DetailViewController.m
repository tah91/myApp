//
//  Detail2ViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 24/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "ControllerHelper.h"
#import "AppDelegate.h"
#import "DescriptionViewController.h"
#import "GalleryViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize picture;
@synthesize localisation,locId;

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
    
    [ApplicationDelegate.localisationEngine detailsWithId:[NSNumber numberWithInt:locId]
                                             onCompletion:^(NSObject* localisationJson) {
                                                 NSMutableDictionary* json = (NSMutableDictionary*)localisationJson;
                                                 [self loadData:json];
                                             }
                                                  onError:^(NSError* error) {
                                                      ALERT_TITLE(@"Erreur",[error localizedDescription])
                                                  }];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setPicture:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)loadData:(NSMutableDictionary*)json {    
    localisation = [[Localisation alloc] initWithDictionary:json];
    picture.image = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:[localisation getMainImage:false]]]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"descriptionSegue"] || [[segue identifier] isEqualToString:@"descDetailSegue"]) {
        
        DescriptionViewController* dc = [segue destinationViewController];
        [dc setLocalisation:localisation];
        [dc setSelectedTab:0];
        
    } else if ([[segue identifier] isEqualToString:@"infosSegue"]) {
        
        DescriptionViewController* dc = [segue destinationViewController];
        [dc setLocalisation:localisation];
        [dc setSelectedTab:1];
        
    } else if ([[segue identifier] isEqualToString:@"gallerySegue"]) {
        
        GalleryViewController* gc = [segue destinationViewController];
        [gc setLocalisation:localisation];
        
    } else if ([[segue identifier] isEqualToString:@"reviewsSegue"]) {
        
    } else if ([[segue identifier] isEqualToString:@"desktopsSegue"]) {
        
    } else if ([[segue identifier] isEqualToString:@"meetingsSegue"]) {
        
    }
    
}

@end
