//
//  DetailViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Localisation.h"

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property int locId;

@end
