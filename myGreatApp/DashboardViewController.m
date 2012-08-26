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
#import "UIViewController+TIAdditions.h"
#import "DetailCell.h"
#import "UIView+TIAdditions.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController
@synthesize avatar;
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
    [self.navigationController cleanNavigationStackAndKeep:[DashboardViewController class]];
    self.nameLabel.text = [ApplicationDelegate.loginSession authData].firstName;
    [self.avatar setImageWithStyle:[UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:[ApplicationDelegate.loginSession authData].avatar]]]];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setAvatar:nil];
    [self setNameLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCell* cell = [tableView dequeueReusableCellWithIdentifier:@"dashboardCell"];
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                    cell.titleLabel.text = @"Mes infos générales";
                    break;
                case 1:
                    cell.titleLabel.text = @"Mon mot de passe";
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            [self performSegueWithIdentifier:@"editProfilSegue" sender:self];
        }
            break;
        case 1:
        {
            [self performSegueWithIdentifier:@"editPasswordSegue" sender:self];
        }
            break;
        default:
            break;
    }
}

- (IBAction)logout:(id)sender
{
    [ApplicationDelegate.loginSession logoutOnSucess:^(void){
        //[self.navigationController popToRootViewControllerAnimated:FALSE];
        [self performSegueWithIdentifier:@"logoutSegue" sender:self];
                                                }
                                             onError:^(NSError* error) {
                                                  ALERT_TITLE(@"Erreur",[error localizedDescription])
                                              }];
}

@end
