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
#import "DashboardViewController.h"
#import "UINavigationController+TIAdditions.h"
#import "DetailCell.h"

@interface ProfilViewController ()

@end

@implementation ProfilViewController
@synthesize tableView;

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
    } else {
        [self.navigationController cleanNavigationStackAndKeep:[ProfilViewController class]];
    }
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"loginSegue"]) {
        //destination is navigation controller
        UINavigationController *parent = segue.destinationViewController;
        LoginViewController *lvc = (LoginViewController*)[parent topViewController];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableViewVal cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCell* cell = [tableViewVal dequeueReusableCellWithIdentifier:@"profilCell"];
    cell.titleLabel.text = @"Se connecter ou s'inscrire";
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                    [self performSegueWithIdentifier:@"loginSegue" sender:self];
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
}

@end
