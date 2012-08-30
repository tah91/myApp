//
//  SelectSearchViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SelectSearchViewController.h"
#import "ResultViewController.h"
#import "SearchButtonView.h"
#import "UIView+TIAdditions.h"

@interface SelectSearchViewController ()

@end

@implementation SelectSearchViewController
@synthesize freeSpaceButton;
@synthesize desktopButton;
@synthesize meetingRoomButton;
@synthesize launchSearchBtn;

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

    self.view.backgroundColor = BNG_PATTERN;
    
    [SearchButtonView setBtn:freeSpaceButton owner:self title:NSLocalizedString(@"Lieux gratuits",nil) withSubtitle:NSLocalizedString(@"Lieux gratuits sous titre",nil)];
    [SearchButtonView setBtnState:freeSpaceButton state:criteria.freePlace image:[UIImage imageNamed:@"select-search-free-off.png"] selectedImage:[UIImage imageNamed:@"select-search-free-on.png"]];
    [freeSpaceButton setSelected:criteria.freePlace];

    [SearchButtonView setBtn:desktopButton owner:self title:NSLocalizedString(@"Bureaux",nil) withSubtitle:NSLocalizedString(@"Bureaux sous titre",nil)];
    [SearchButtonView setBtnState:desktopButton state:criteria.desktop image:[UIImage imageNamed:@"select-search-desktop-off.png"] selectedImage:[UIImage imageNamed:@"select-search-desktop-on.png"]];
    [desktopButton setSelected:criteria.desktop];

    [SearchButtonView setBtn:meetingRoomButton owner:self title:NSLocalizedString(@"Salles de réunion",nil) withSubtitle:NSLocalizedString(@"Salles de réunion sous titre",nil)];
    [SearchButtonView setBtnState:meetingRoomButton state:criteria.meetingRoom image:[UIImage imageNamed:@"select-search-meeting-off.png"] selectedImage:[UIImage imageNamed:@"select-search-meeting-on.png"]];
    [meetingRoomButton setSelected:criteria.meetingRoom];
    
    self.navigationItem.title = NSLocalizedString(@"Filtrer",nil);
    [self.launchSearchBtn setButtonWithStyle:NSLocalizedString(@"Lancer la recherche",nil)];
}

- (void)viewDidUnload
{
    [self setFreeSpaceButton:nil];
    [self setDesktopButton:nil];
    [self setMeetingRoomButton:nil];
    [self setLaunchSearchBtn:nil];
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

- (IBAction)selectFreeSpace:(id)sender
{
    BOOL isSelected = [sender isSelected];
    [SearchButtonView setBtnState:freeSpaceButton state:!isSelected image:[UIImage imageNamed:@"select-search-free-off.png"] selectedImage:[UIImage imageNamed:@"select-search-free-on.png"]];
    if (isSelected) {
        [sender setSelected:NO];
        [criteria setFreePlace:false];
    }else {
        [sender setSelected:YES];
        [criteria setFreePlace:true];
    }
}

- (IBAction)selectDesktop:(id)sender
{
    BOOL isSelected = [sender isSelected];
    [SearchButtonView setBtnState:desktopButton state:!isSelected image:[UIImage imageNamed:@"select-search-desktop-off.png"] selectedImage:[UIImage imageNamed:@"select-search-desktop-on.png"]];
    if (isSelected) {
        [sender setSelected:NO];
        [criteria setDesktop:false];
    }else {
        [sender setSelected:YES];
        [criteria setDesktop:true];
    }
}

- (IBAction)selectMeetingRoom:(id)sender
{
    BOOL isSelected = [sender isSelected];
    [SearchButtonView setBtnState:meetingRoomButton state:!isSelected image:[UIImage imageNamed:@"select-search-meeting-off.png"] selectedImage:[UIImage imageNamed:@"select-search-meeting-on.png"]];
    if (isSelected) {
        [sender setSelected:NO];
        [criteria setMeetingRoom:false];
    }else {
        [sender setSelected:YES];
        [criteria setMeetingRoom:true];
    }
}
@end
