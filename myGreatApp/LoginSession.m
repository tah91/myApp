//
//  FBSession.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginSession.h"
#import "MKNetworkEngine.h"
#import "AppDelegate.h"

@implementation LoginSession

@synthesize facebook, loginSuccessCallback, loginfailedCallback, fbRequestHandler;

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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:@"isLoggedIn"];
}

-(void)storeUserInfo:(NSObject*)userInfo {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:TRUE forKey:@"isLoggedIn"];
    [defaults setObject:[userInfo valueForKey:@"token"] forKey:@"eworkyToken"];
    [defaults setObject:[userInfo valueForKey:@"email"] forKey:@"eworkyLogin"];
    [defaults setObject:[userInfo valueForKey:@"firstname"] forKey:@"eworkyFirstName"];
    [defaults setObject:[userInfo valueForKey:@"name"] forKey:@"eworkyLastName"];
    [defaults synchronize];
}

-(void)cleanUserInfo {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:FALSE forKey:@"isLoggedIn"];
    [defaults removeObjectForKey:@"eworkyToken"];
    [defaults removeObjectForKey:@"eworkyLogin"];
    [defaults removeObjectForKey:@"eworkyFirstName"];
    [defaults removeObjectForKey:@"eworkyLastName"];
    [defaults synchronize];
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
                                                    if (userInfo == nil) {
                                                        NSError* error = [[NSError alloc] initWithDomain:@"myDomain" code:100 userInfo:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Erreur lors de l'inscription",NSLocalizedDescriptionKey,nil]];
                                                        errorBlock(error);
                                                    } else {
                                                        [self storeUserInfo:userInfo];
                                                        successBlock();
                                                    }
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
                                                    if (userInfo == nil) {
                                                        NSError* error = [[NSError alloc] initWithDomain:@"myDomain" code:100 userInfo:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Erreur lors de la connexion",NSLocalizedDescriptionKey,nil]];
                                                        errorBlock(error);
                                                    } else {
                                                        [self storeUserInfo:userInfo];
                                                        successBlock();
                                                    }
                                                }
                                                     onError:^(NSError* error) {
                                                         errorBlock(error);
                                                     }];
}

/**
 * Invalidate the access token and clear the cookie.
 */
- (void)logoutOnSucess:(LoginSuccessBlock)success 
               onError:(LoginFailedBlock)error; {
    [self fbLogout];
    [self cleanUserInfo];
    
    success();
}

/**
 * Show the fb authorization dialog.and set success block, will be executed in delegate after login succeded
 */
- (void)fbLoginOnSucess:(LoginSuccessBlock)success 
                onError:(LoginFailedBlock)error {
    if (![facebook isSessionValid]) {
        [facebook authorize:[NSArray arrayWithObjects:@"email", @"user_birthday", @"publish_actions",nil]];
    } else {
        success();
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
    
    fbRequestHandler = [[FBRequestBlockDelegate alloc] initWithDidLoad:^(FBRequest* request, id result) {
        
        if ([result isKindOfClass:[NSArray class]]) {
            result = [result objectAtIndex:0];
        }
        
        NSString* name = [result objectForKey:@"first_name"];
        NSString* lastName = [result objectForKey:@"last_name"];
        NSString* login = [result objectForKey:@"email"];
        NSNumber* fbId = [result objectForKey:@"id"];
        NSString* fbLink = [result objectForKey:@"link"];
        NSString* birthDate = [result objectForKey:@"birthday"];
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        NSDate* birth = [dateFormatter dateFromString:birthDate];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        birthDate = [dateFormatter stringFromDate:birth];
        
        
        [ApplicationDelegate.localisationEngine registerWithName:name 
                                                        lastName:lastName 
                                                           login:login 
                                                        password:@"" 
                                                       birthDate:birthDate 
                                                      facebookId:fbId
                                                    facebookLink:fbLink
                                                    onCompletion:^(NSObject* userInfo) {
                                                        if (userInfo == nil) {
                                                            NSError* error = [[NSError alloc] initWithDomain:@"myDomain" code:100 userInfo:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Erreur lors de la connexion via Facebook",NSLocalizedDescriptionKey,nil]];
                                                            loginfailedCallback(error);
                                                        } else {
                                                            [self storeUserInfo:userInfo];
                                                            loginSuccessCallback();
                                                        }
                                                    }
                                                         onError:^(NSError* error) {
                                                             loginfailedCallback(error);
                                                         }];
        
    } andDidFail:^(FBRequest* request, NSError* error) {
                loginfailedCallback(error);
    }];
    
    [facebook requestWithGraphPath:@"me?fields=id,name,email,first_name,last_name,link,birthday" andDelegate:fbRequestHandler];
}

-(void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    NSLog(@"token extended");
    [self storeAuthData:accessToken expiresAt:expiresAt];
}

/**
 * Called when the user canceled the authorization dialog.
 */
-(void)fbDidNotLogin:(BOOL)cancelled {
    NSError* error = [[NSError alloc] initWithDomain:@"myDomain" code:100 userInfo:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Failed to login with facebook",NSLocalizedDescriptionKey,nil]];
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
