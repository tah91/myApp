//
//  ProfilViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface ProfilViewController : UIViewController <LoginViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
