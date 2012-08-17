//
//  RegisterViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 20/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RegisterViewController.h"
#import "AppDelegate.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize firstName;
@synthesize lastName;
@synthesize email;
@synthesize password;
@synthesize loginDelegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setFirstName:nil];
    [self setLastName:nil];
    [self setEmail:nil];
    [self setPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)fbRegister:(id)sender {
    [ApplicationDelegate.loginSession fbLoginOnSucess:^(void) {
        [loginDelegate finishedLoadingUserInfo];
    }
                                              onError:^(NSError* error) {
                                                  ALERT_TITLE(@"Erreur",[error localizedDescription])
                                              }];
}

- (IBAction)register:(id)sender {
    if([firstName.text length]==0 || [lastName.text length]==0 || [email.text length]==0 || [password.text length]==0) {
        ALERT_TITLE(@"Erreur",@"Remplissez tous les chammps")
    } else {
        [ApplicationDelegate.loginSession registerWithName:firstName.text 
                                                  lastName:lastName.text 
                                                     login:email.text 
                                                  password:password.text 
                                                  onSucess:^(void) {
                                                      [loginDelegate finishedLoadingUserInfo];
                                                  }
                                                   onError:^(NSError* error) {
                                                       ALERT_TITLE(@"Erreur",[error localizedDescription])
                                                   }];
    }
}
@end
