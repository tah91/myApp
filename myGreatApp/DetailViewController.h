//
//  Detail2ViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 24/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Localisation.h"

@interface DetailViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIImageView *picture;

@property NSInteger locId;
@property (strong, nonatomic) Localisation* localisation;

@end
