//
//  DashboardViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 15/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DashboardViewController.h"
#import "AppDelegate.h"
#import "ProfilViewController.h"
#import "ControllerHelper.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController
@synthesize nameLabel;

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
    [ControllerHelper removeFromStackNavigation:self.navigationController
                                         aclass:[DashboardViewController class]];
	// Do any additional setup after loading the view.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    nameLabel.text = [defaults objectForKey:@"eworkyFirstName"];
}

- (void)viewDidUnload
{
    [self setNameLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)logout:(id)sender {
    [ApplicationDelegate.loginSession logoutOnSucess:^(void){
        //[self.navigationController popToRootViewControllerAnimated:FALSE];
        [self performSegueWithIdentifier:@"logoutSegue" sender:self];
                                                }
                                             onError:^(NSError* error) {
                                                  ALERT_TITLE(@"Erreur",[error localizedDescription])
                                              }];
}
@end
