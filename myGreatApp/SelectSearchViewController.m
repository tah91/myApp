//
//  SelectSearchViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SelectSearchViewController.h"
#import "ResultViewController.h"

@interface SelectSearchViewController ()

@end

@implementation SelectSearchViewController
@synthesize freeSpaceButton;
@synthesize desktopButton;
@synthesize meetingRoomButton;

@synthesize criteria;

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
    [freeSpaceButton setImage:[UIImage imageNamed:@"freeplaces.png"] forState:UIControlStateNormal];
    [freeSpaceButton setImage:[UIImage imageNamed:@"freeplaces_u.png"] forState:UIControlStateSelected];
    [freeSpaceButton setSelected:criteria.freePlace];
    [desktopButton setImage:[UIImage imageNamed:@"desktop.png"] forState:UIControlStateNormal];
    [desktopButton setImage:[UIImage imageNamed:@"desktop_u.png"] forState:UIControlStateSelected];
    [desktopButton setSelected:criteria.desktop];
    [meetingRoomButton setImage:[UIImage imageNamed:@"meetingroom.png"] forState:UIControlStateNormal];
    [meetingRoomButton setImage:[UIImage imageNamed:@"meetingroom_u.png"] forState:UIControlStateSelected];
    [meetingRoomButton setSelected:criteria.meetingRoom];
    
    [self performSegueWithIdentifier:@"resultSegue" sender:self];
}

- (void)viewDidUnload
{
    [self setFreeSpaceButton:nil];
    [self setDesktopButton:nil];
    [self setMeetingRoomButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"resultSegue"]) {
        
        ResultViewController* rvc = [segue destinationViewController];
        
        [rvc setCriteria:criteria];
    }
}

- (IBAction)selectFreeSpace:(id)sender {
    if ([sender isSelected]) {
        [sender setSelected:NO];
        [criteria setFreePlace:false];
    }else {
        [sender setSelected:YES];
        [criteria setFreePlace:true];
    }
}

- (IBAction)selectDesktop:(id)sender {
    if ([sender isSelected]) {
        [sender setSelected:NO];
        [criteria setDesktop:false];
    }else {
        [sender setSelected:YES];
        [criteria setDesktop:true];
    }
}

- (IBAction)selectMeetingRoom:(id)sender {
    if ([sender isSelected]) {
        [sender setSelected:NO];
        [criteria setMeetingRoom:false];
    }else {
        [sender setSelected:YES];
        [criteria setMeetingRoom:true];
    }
}
@end
