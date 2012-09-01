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
@synthesize tableView;
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
    [self.tableView registerNib:[UINib nibWithNibName:kDetailCellIdent bundle:nil] forCellReuseIdentifier:kDetailCellIdent];
    
    [super viewDidLoad];
    [self.navigationController cleanNavigationStackAndKeep:[DashboardViewController class]];
    self.nameLabel.text = [ApplicationDelegate.loginSession authData].firstName;
    self.nameLabel.textColor = BLUE_COLOR;
    //[self.avatar setImageWithStyle:[ApplicationDelegate.loginSession authData].avatar emptyName:@"avatar.png"];
    self.navigationItem.title = NSLocalizedString(@"Profil",nil);
    
    UIBarButtonItem* logoutBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Déconnexion",nil)
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(logout:)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:logoutBtn, nil];
    
    self.tableView.backgroundColor = BNG_PATTERN;
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setAvatar:nil];
    [self setNameLabel:nil];
    [self setTableView:nil];
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

- (UITableViewCell *)tableView:(UITableView *)tableViewVal cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCell* cell = [tableViewVal dequeueReusableCellWithIdentifier:kDetailCellIdent];
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                    [cell setLabel:NSLocalizedString(@"Mes infos générales",nil) withSegue:@"editProfilSegue" andController:self];
                    break;
                case 1:
                    [cell setLabel:NSLocalizedString(@"Mon mot de passe",nil) withSegue:@"editPasswordSegue" andController:self];
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

}

- (IBAction)logout:(id)sender
{
    [ApplicationDelegate.loginSession logoutOnSucess:^(void){
        //[self.navigationController popToRootViewControllerAnimated:FALSE];
        [self performSegueWithIdentifier:@"logoutSegue" sender:self];
                                                }
                                             onError:^(NSError* error) {
                                                  ALERT_TITLE(NSLocalizedString(@"Erreur",nil),[error localizedDescription])
                                              }];
}

@end
