//
//  RegisterViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 20/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "FormViewController.h"

@interface RegisterViewController : FormViewController <UITextFieldDelegate, InteractionLabelSelection>

- (IBAction)fbRegister:(id)sender;
- (IBAction)ewRegister:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *fbRegisterBtn;
@property (weak, nonatomic) IBOutlet UILabel *noFbLabel;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet InteractionLabel *cguLabel;

@property (strong,nonatomic) id <LoginViewControllerDelegate> loginDelegate;

@end
