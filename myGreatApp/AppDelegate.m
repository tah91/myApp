//
//  AppDelegate.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "LocalisationEngine.h"

//#define HOST_NAME @"www.eworky.fr"
#define HOST_NAME @"taff.coworky.fr"
//#define HOST_NAME @"ti.coworky.fr"

@implementation AppDelegate

@synthesize window = _window;
@synthesize localisationEngine;
@synthesize loginSession;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.localisationEngine = [[LocalisationEngine alloc] initWithHostName:HOST_NAME customHeaderFields:nil];
    //[self.localisationEngine useCache];
    //[self.localisationEngine emptyCache];
    
    self.loginSession = [[LoginSession alloc] initWithId:@"339911822753190"];
    
    UIImage *navBarImage = [UIImage imageNamed:@"nav-bar.png"];
    
    [[UINavigationBar appearance] setBackgroundImage:navBarImage
                                       forBarMetrics:UIBarMetricsDefault];
    
    
    NSDictionary* barColor = [NSDictionary dictionaryWithObjectsAndKeys:
                              [UIColor colorWithRed:3.0/255.0 green:84.0/255.0 blue:131.0/255.0 alpha:1.0],UITextAttributeTextColor,
                              [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0],UITextAttributeTextShadowColor,
                              [UIFont fontWithName:@"Helvetica CE 55 Roman" size:0.0],UITextAttributeFont,
                              nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:barColor];
    
    UIImage *barButton = [[UIImage imageNamed:@"nav-button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 8, 5, 9)];
    
    [[UIBarButtonItem appearance] setBackgroundImage:barButton
                                            forState:UIControlStateNormal
                                          barMetrics:UIBarMetricsDefault];
    
    UIImage *backButton = [[UIImage imageNamed:@"nav-back.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5,18,5,8)];
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButton
                                                      forState:UIControlStateNormal
                                                    barMetrics:UIBarMetricsDefault];
    
    NSDictionary* buttonColor = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [UIColor colorWithRed:0.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0],UITextAttributeTextColor,
                                 [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0],UITextAttributeTextShadowColor,
                                 //[NSValue valueWithUIOffset:UIOffsetMake(0,1)],UITextAttributeTextShadowOffset,
                                 [UIFont fontWithName:@"Helvetica CE 55 Roman" size:0.0],UITextAttributeFont,
                                 nil];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:buttonColor
                                                forState:UIControlStateNormal];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self.loginSession.facebook handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self.loginSession.facebook handleOpenURL:url];
}

@end
