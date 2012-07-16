//
//  ProfilViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProfilViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

@interface ProfilViewController ()

@end

@implementation ProfilViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if([ApplicationDelegate.loginSession isLogged]){
        [self performSegueWithIdentifier:@"dashboardSegue" sender:self];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)goToLogin:(id)sender {
    [self performSegueWithIdentifier:@"goToLoginSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goToLoginSegue"]) {
        LoginViewController *lvc = segue.destinationViewController;
        lvc.loginDelegate = self; // For the delegate method
    }
}

#pragma mark - LoginViewController Delegate Method
-(void)finishedLoadingUserInfo
{    
    // Dismiss the LoginViewController that we instantiated earlier
    [self dismissModalViewControllerAnimated:YES];
    
    // Do other stuff as needed
    [self performSegueWithIdentifier:@"dashboardSegue" sender:self];
}

@end
