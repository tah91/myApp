//
//  LoginViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize email;
@synthesize password;
@synthesize loginDelegate;

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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setEmail:nil];
    [self setPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)fbLogin:(id)sender {
    [ApplicationDelegate.loginSession fbLoginOnSucess:^(void){
                                        [loginDelegate finishedLoadingUserInfo];
                                        }
                                              onError:^(NSError* error) {
                                                  DLog(@"%@", error);
                                              }];
}

- (IBAction)login:(id)sender {
    [ApplicationDelegate.loginSession login:email.text 
                                   password:password.text 
                                   onSucess:^(void){
                                       [loginDelegate finishedLoadingUserInfo];
                                   }onError:^(NSError* error) {
                                       DLog(@"%@", error);
                                   }];
}

- (IBAction)cancel:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
