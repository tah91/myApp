//
//  LoginViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"

@protocol LoginViewControllerDelegate

-(void)finishedLoadingUserInfo;

@end

@interface LoginViewController : UIViewController <FBRequestDelegate> {

}

- (IBAction)fbLogin:(id)sender;
- (IBAction)login:(id)sender;
- (IBAction)cancel:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
    
@property (strong,nonatomic) id <LoginViewControllerDelegate> loginDelegate;

@end
