//
//  GalleryViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 25/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATPagingView.h"
#import "Localisation.h"

@interface GalleryViewController : ATPagingViewController

@property (strong, nonatomic) Localisation* localisation;

@end
