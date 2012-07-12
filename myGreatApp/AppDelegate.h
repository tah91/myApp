//
//  AppDelegate.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalisationEngine.h"
#import "FBSession.h"

#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow* window;

@property (strong, nonatomic) LocalisationEngine* localisationEngine;

@property (strong, nonatomic) FBSession* fbSession;

@end
