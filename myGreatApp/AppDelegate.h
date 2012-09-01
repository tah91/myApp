//
//  AppDelegate.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define HOST_NAME @"www.eworky.fr"
//#define HOST_NAME @"taff.coworky.fr"
//#define HOST_NAME @"ti.coworky.fr"

#import <UIKit/UIKit.h>
#import "LocalisationEngine.h"
#import "LoginSession.h"
#import <CoreLocation/CoreLocation.h>

#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow* window;

@property (strong, nonatomic) LocalisationEngine* localisationEngine;

@property (strong, nonatomic) LoginSession* loginSession;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSNumber* latitude;
@property (strong, nonatomic) NSNumber* longitude;

@end
