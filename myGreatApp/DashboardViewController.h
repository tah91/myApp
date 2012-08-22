//
//  DashboardViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 15/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

- (IBAction)logout:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
