//
//  SelectSearchViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchCriteria.h"

@interface SelectSearchViewController : UIViewController

@property (strong, nonatomic) SearchCriteria* criteria;
- (IBAction)toogle:(id)sender;

@end
