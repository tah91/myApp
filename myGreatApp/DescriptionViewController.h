//
//  DescriptionViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 24/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Localisation.h"

@interface DescriptionViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tabSelector;
@property (strong, nonatomic) IBOutlet UILabel *descLabel;
@property (strong, nonatomic) IBOutlet UIView *infosView;
@property (strong, nonatomic) IBOutlet UITableView *featuresTableView;
- (IBAction)tabChanged:(id)sender;

@property (nonatomic) NSInteger selectedTab;
@property (strong, nonatomic) Localisation* localisation;

@end
