//
//  SearchViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"
#import "ResultViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize searchPlace;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setSearchPlace:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)doSearch:(id)sender {
    [self performSegueWithIdentifier:@"resultSegue" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"resultSegue"]) {
        
        ResultViewController *rs = [segue destinationViewController];
        
        NSString* place = searchPlace.text;
        [rs setSearchPlace:place];
    }
}

- (IBAction)placeEntered:(id)sender {
    [sender resignFirstResponder];
}

@end
