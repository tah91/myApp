//
//  DetailViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "ControllerHelper.h"
#import "AppDelegate.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize name;
@synthesize city;
@synthesize picture;
@synthesize locId;
@synthesize localisation;

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
    
    [ApplicationDelegate.localisationEngine detailsWithId:[NSNumber numberWithInt:locId]
                                             onCompletion:^(NSObject* localisationJson) {
                                                 NSMutableDictionary* json = (NSMutableDictionary*)localisationJson;
                                                 localisation = [[Localisation alloc] initWithDictionary:json];
                                                 name.text = [NSString stringWithFormat:@"name is : %@", localisation.name];
                                                 picture.image = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:localisation.image]]];
                                             }
                                                  onError:^(NSError* error) {
                                                      ALERT_TITLE(@"Erreur",[error localizedDescription])
                                                  }];
    
    self.navigationItem.backBarButtonItem.title = @"Back";
}

- (void)viewDidUnload
{
    [self setName:nil];
    [self setCity:nil];
    [self setPicture:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
