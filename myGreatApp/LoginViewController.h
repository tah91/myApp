//
//  LoginViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"
#import "FormViewController.h"

@protocol LoginViewControllerDelegate

-(void)finishedLoadingUserInfo;

@end

@interface LoginViewController : FormViewController <FBRequestDelegate, UITableViewDelegate, UITableViewDataSource>

- (IBAction)fbLogin:(id)sender;
- (IBAction)login:(id)sender;
- (IBAction)cancel:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *fbLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UILabel *alreadyMember1;
@property (weak, nonatomic) IBOutlet UILabel *alreadyMember2;
@property (weak, nonatomic) IBOutlet UILabel *needAccount1;
@property (weak, nonatomic) IBOutlet UILabel *needAccount2;

@property (strong,nonatomic) id <LoginViewControllerDelegate> loginDelegate;

@end
