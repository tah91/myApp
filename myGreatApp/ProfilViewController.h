//
//  ProfilViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"

@interface ProfilViewController : UIViewController  <FBRequestDelegate>

- (IBAction)fbLogout:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
