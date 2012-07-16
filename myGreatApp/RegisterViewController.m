//
//  RegisterViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 16/07/12.
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
    [self setFirstName:nil];
    [self setLastName:nil];
    [self setEmail:nil];
    [self setPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)fbRegister:(id)sender {
    [ApplicationDelegate.loginSession fbLoginOnSucess:^(void) {
                                            [delegate finishedLoadingUserInfo];
                                        }
                                              onError:^(NSError* error) {
                                                  DLog(@"%@", error);
                                              }];
}

- (IBAction)register:(id)sender {
    [ApplicationDelegate.loginSession registerWithName:firstName.text 
                                              lastName:lastName.text 
                                                 login:email.text 
                                              password:password.text 
                                              onSucess:^(void) {
                                                  [delegate finishedLoadingUserInfo];
                                              }
                                               onError:^(NSError* error) {
                                                   DLog(@"%@", error);
                                               }];
}
@end
