//
//  FBSession.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginSession.h"
#import "FBRequestBlockDelegate.h"
#import "MKNetworkEngine.h"
#import "AppDelegate.h"

@implementation LoginSession

@synthesize facebook, loginSuccessCallback, loginfailedCallback;

-(id) initWithId:(NSString*)appId;
{
    if (!(self = [super init]))
        return nil;
    
    self.facebook = [[Facebook alloc] initWithAppId:appId andDelegate:self];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    return self;
}

/**
 * Tell if user is logged in
 */
- (BOOL)isLogged {
    return [facebook isSessionValid];
}

/**
 * Register and store login data, then execute success block
 */
//
- (void)registerWithName:(NSString*)name 
                lastName:(NSString*)lastName 
                   login:(NSString*)login 
                password:(NSString*)password 
                onSucess:(LoginSuccessBlock)successBlock 
                 onError:(LoginFailedBlock)errorBlock {
    
    [ApplicationDelegate.localisationEngine registerWithName:name 
                                                    lastName:lastName 
                                                       login:login 
                                                    password:password
                                                onCompletion:^(NSObject* userInfo) {
                                                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                                    [defaults setBool:TRUE forKey:@"isLoggedIn"];
                                                    [defaults setObject:@"token" forKey:@"eworkyToken"];
                                                    [defaults setObject:login forKey:@"eworkyLogin"]; 
                                                    [defaults synchronize];
                                                    successBlock();
                                                }
                                                     onError:^(NSError* error) {
                                                         errorBlock(error);
                                                     }];
}

/**
 * Login and store login data, then execute success block
 */
- (void)login:(NSString*)login 
     password:(NSString*)password 
     onSucess:(LoginSuccessBlock)successBlock 
      onError:(LoginFailedBlock)errorBlock {
    
    [ApplicationDelegate.localisationEngine connectWithLogin:login
                                                    password:password 
                                                onCompletion:^(NSObject* userInfo) {
                                                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                                    [defaults setBool:TRUE forKey:@"isLoggedIn"];
                                                    [defaults setObject:@"token" forKey:@"eworkyToken"];
                                                    [defaults setObject:login forKey:@"eworkyLogin"]; 
                                                    [defaults synchronize];
                                                    successBlock();
                                                }
                                                     onError:^(NSError* error) {
                                                         errorBlock(error);
                                                     }];
}

/**
 * Invalidate the access token and clear the cookie.
 */
- (void)logout {
    [self fbLogout];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:FALSE forKey:@"isLoggedIn"];
    [defaults removeObjectForKey:@"eworkyToken"];
    [defaults removeObjectForKey:@"eworkyLogin"];
    [defaults synchronize];
}

/**
 * Show the fb authorization dialog.and set success block, will be executed in delegate after login succeded
 */
- (void)fbLoginOnSucess:(LoginSuccessBlock)success 
                onError:(LoginFailedBlock)error {
    if (![facebook isSessionValid]) {
        [facebook authorize:nil];
    } else {
        //
    }
    
    loginSuccessCallback = success;
    loginfailedCallback = error;
}

/**
 * Invalidate the access token and clear the cookie.
 */
- (void)fbLogout {
    [facebook logout];
}

- (void)storeAuthData:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:expiresAt forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}

#pragma mark - FBSessionDelegate Methods

/**
 * Called when the user has logged in successfully.
 * store fb token, request user data via open graph, register user, then store user info if succeded.
 */
- (void)fbDidLogin {
    //[self showLoggedIn];
    
    [self storeAuthData:[facebook accessToken] expiresAt:[facebook expirationDate]];
    
    FBRequestBlockDelegate* fbRequestHandler = [[FBRequestBlockDelegate alloc] initWithDidLoad:^(FBRequest* request, id result) {
        
        if ([result isKindOfClass:[NSArray class]]) {
            result = [result objectAtIndex:0];
        }
        
        NSString* name = [result objectForKey:@"name"];
        NSString* lastName = [result objectForKey:@"lastName"];
        NSString* login = [result objectForKey:@"mail"];
        
        [ApplicationDelegate.localisationEngine registerWithName:name 
                                                        lastName:lastName 
                                                           login:login 
                                                        password:@""
                                                    onCompletion:^(NSObject* userInfo) {
                                                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                                        [defaults setBool:TRUE forKey:@"isLoggedIn"];
                                                        [defaults setObject:@"token" forKey:@"eworkyToken"];
                                                        [defaults setObject:login forKey:@"eworkyLogin"]; 
                                                        [defaults synchronize];
                                                        loginSuccessCallback();
                                                    }
                                                         onError:^(NSError* error) {
                                                             loginfailedCallback(error);
                                                         }];
        
    } andDidFail:^(FBRequest* request, NSError* error) {
                loginfailedCallback(error);
    }];
    
    [facebook requestWithGraphPath:@"me" andDelegate:fbRequestHandler];
}

-(void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    NSLog(@"token extended");
    [self storeAuthData:accessToken expiresAt:expiresAt];
}

/**
 * Called when the user canceled the authorization dialog.
 */
-(void)fbDidNotLogin:(BOOL)cancelled {
    NSMutableDictionary* errorDetail = [NSMutableDictionary dictionary];
    [errorDetail setValue:@"Failed to login with facebook" forKey:NSLocalizedDescriptionKey];
    NSError* error = [[NSError alloc] initWithDomain:@"myDomain" code:100 userInfo:errorDetail];
    loginfailedCallback(error);
}

/**
 * Called when the request logout has succeeded.
 */
- (void)fbDidLogout {
    
    // Remove saved authorization information if it exists and it is
    // ok to clear it (logout, session invalid, app unauthorized)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    //[self showLoggedOut];
}

/**
 * Called when the session has expired.
 */
- (void)fbSessionInvalidated {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Auth Exception"
                              message:@"Your session has expired."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil,
                              nil];
    [alertView show];
    [self fbDidLogout];
}

@end
