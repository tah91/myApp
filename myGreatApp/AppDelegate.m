//
//  AppDelegate.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "LocalisationEngine.h"
#import "SHKConfiguration.h"
#import "Libraries/EworkySHKConfigurator.h"
#import "ProfilViewController.h"
#import "FavoritesViewController.h"
#import "UIView+TIAdditions.h"

#import "SHKFacebook.h"

#define HOST_NAME @"www.eworky.fr"
//#define HOST_NAME @"taff.coworky.fr"
//#define HOST_NAME @"ti.coworky.fr"

@implementation AppDelegate

@synthesize window = _window;
@synthesize localisationEngine;
@synthesize loginSession;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    DefaultSHKConfigurator* configurator = [[EworkySHKConfigurator alloc] init];
    [SHKConfiguration sharedInstanceWithConfigurator:configurator];
    
    UITabBarController* _tabBarController = (UITabBarController *)self.window.rootViewController;
    _tabBarController.delegate = self;
    
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
                              FONT_BOLD(18.0f),UITextAttributeFont,
                              nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:barColor];
    
    UIImage *barButton = [[UIImage imageNamed:@"nav-btn.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 9, 6, 9)];
    UIImage *barButtonSel = [[UIImage imageNamed:@"nav-btn-sel.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 9, 6, 9)];
    
    [[UIBarButtonItem appearance] setBackgroundImage:barButton
                                            forState:UIControlStateNormal
                                          barMetrics:UIBarMetricsDefault];
    
    [[UIBarButtonItem appearance] setBackgroundImage:barButtonSel
                                            forState:UIControlStateSelected
                                          barMetrics:UIBarMetricsDefault];
    
    UIImage *backButton = [[UIImage imageNamed:@"nav-btn-back.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(6,18,6,8)];
    UIImage *backButtonSel = [[UIImage imageNamed:@"nav-btn-back-sel.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(6,18,6,8)];
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButton
                                                      forState:UIControlStateNormal
                                                    barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonSel
                                                      forState:UIControlStateHighlighted
                                                    barMetrics:UIBarMetricsDefault];
    
    NSDictionary* buttonColor = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [UIColor colorWithRed:0.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0],UITextAttributeTextColor,
                                 [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0],UITextAttributeTextShadowColor,
                                 FONT_BOLD(12.0f),UITextAttributeFont,
                                 nil];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:buttonColor
                                                forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:buttonColor
                                                forState:UIControlStateHighlighted];
    
    UIImage *segmentSelected = [[UIImage imageNamed:@"seg-control-sel.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 5, 5, 5)];
    UIImage *segmentUnselected = [[UIImage imageNamed:@"seg-control-uns.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    UIImage *segmentSelectedUnselected = [UIImage imageNamed:@"seg-control-sel-uns.png"];
    UIImage *segUnselectedSelected = [UIImage imageNamed:@"seg-control-uns-sel.png"];
    UIImage *segmentUnselectedUnselected = [UIImage imageNamed:@"seg-control-uns-uns.png"];
    UIImage *segmentSelectedSelected = [UIImage imageNamed:@"seg-control-sel-sel.png"];
    
    [[UISegmentedControl appearance] setBackgroundImage:segmentUnselected
                                               forState:UIControlStateNormal
                                             barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setBackgroundImage:segmentSelected
                                               forState:UIControlStateSelected
                                             barMetrics:UIBarMetricsDefault];
    
    [[UISegmentedControl appearance] setDividerImage:segmentUnselectedUnselected
                                 forLeftSegmentState:UIControlStateNormal
                                   rightSegmentState:UIControlStateNormal
                                          barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setDividerImage:segmentSelectedUnselected
                                 forLeftSegmentState:UIControlStateSelected
                                   rightSegmentState:UIControlStateNormal
                                          barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setDividerImage:segmentSelectedSelected
                                 forLeftSegmentState:UIControlStateSelected
                                   rightSegmentState:UIControlStateSelected
                                          barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setDividerImage:segUnselectedSelected
                                 forLeftSegmentState:UIControlStateNormal
                                   rightSegmentState:UIControlStateSelected
                                          barMetrics:UIBarMetricsDefault];
    
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

- (BOOL)handleOpenURL:(NSURL*)url
{
	[self.loginSession.facebook handleOpenURL:url];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [self handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [self handleOpenURL:url];
}

#pragma mark - UITabBarController delegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if(![viewController isKindOfClass:[UINavigationController class]]) {
        return;
    }
    UINavigationController* nav = (UINavigationController*)viewController;
    UIViewController* top = [nav topViewController];
    if(top == nil) {
        return;
    }
    
    if([top isKindOfClass:[FavoritesViewController class]]) {
        FavoritesViewController* fav = (FavoritesViewController*)top;
        [fav shouldFetchData];
    } else if([top isKindOfClass:[ProfilViewController class]]) {
        ProfilViewController* profil = (ProfilViewController*)top;
        [profil shouldAskLogin];
    }
}

@end
