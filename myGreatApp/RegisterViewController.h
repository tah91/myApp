//
//  RegisterViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 16/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface RegisterViewController : UIViewController {
    id <LoginViewControllerDelegate> delegate;
}

- (IBAction)fbRegister:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)register:(id)sender;

@end
