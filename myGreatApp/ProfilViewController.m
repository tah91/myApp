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
#import "UIViewController+TIAdditions.h"
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
    [self.tableView registerNib:[UINib nibWithNibName:kDetailCellIdent bundle:nil] forCellReuseIdentifier:kDetailCellIdent];
    
    [self.navigationController cleanNavigationStackAndKeep:[ProfilViewController class]];
    
    [super viewDidLoad];
    self.tableView.backgroundColor = BNG_PATTERN;
    
    self.navigationItem.title = NSLocalizedString(@"Mon compte",nil);
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"loginSegue"]) {
        [LoginViewController setLoginDelegate:self toController:segue.destinationViewController];
    }
}

- (void)shouldAskLogin
{
    if([ApplicationDelegate.loginSession isLogged]){
        [self performSegueWithIdentifier:@"dashboardSegue" sender:self];
    } else {
        
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
    DetailCell* cell = [tableViewVal dequeueReusableCellWithIdentifier:kDetailCellIdent];
    [cell setLabel:NSLocalizedString(@"Se connecter ou s'inscrire",nil) withSegue:@"loginSegue" andController:self];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
