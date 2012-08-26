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
#import "SHKActivityIndicator.h"

@implementation LoginSession

static NSString *const kSHKFacebookAccessTokenKey=@"kSHKFacebookAccessToken";
static NSString *const kSHKFacebookExpiryDateKey=@"kSHKFacebookExpiryDate";
static NSString *const kSHKFacebookUserInfo =@"kSHKFacebookUserInfo";

@synthesize facebook, loginSuccessCallback, loginfailedCallback, fbRequestHandler;

@dynamic authData;

-(Auth*) authData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData* encodedObject = [defaults objectForKey:@"authData"];
    Auth* toRet = (Auth*)[NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return toRet;
}

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
- (BOOL)isLogged
{
    return self.authData != nil;
}

-(void)storeUserInfo:(NSObject*)userInfo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Auth* authData = [[Auth alloc] initWithDictionary:(NSDictionary*)userInfo];
    NSData* encodedObject = [NSKeyedArchiver archivedDataWithRootObject:authData];
    [defaults setObject:encodedObject forKey:@"authData"];
    [defaults synchronize];
}

-(void)cleanUserInfo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"authData"];
    [defaults synchronize];
    
    [facebook logout];
}

/**
 * Register and store login data, then execute success block
 */
- (void)registerWithName:(NSString*)name 
                lastName:(NSString*)lastName 
                   login:(NSString*)login 
                password:(NSString*)password 
                onSucess:(LoginSuccessBlock)successBlock 
                 onError:(LoginFailedBlock)errorBlock
{
    [[SHKActivityIndicator currentIndicator] displayActivity:@"Inscription en cours"];
    [ApplicationDelegate.localisationEngine registerWithName:name 
                                                    lastName:lastName 
                                                       login:login 
                                                    password:password
                                                onCompletion:^(NSObject* userInfo) {
                                                    if (userInfo == nil) {
                                                        [[SHKActivityIndicator currentIndicator] displayCompleted:@"Erreur de connexion"];
                                                        NSError* error = [[NSError alloc] initWithDomain:@"myDomain" code:100 userInfo:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Erreur lors de l'inscription",NSLocalizedDescriptionKey,nil]];
                                                        errorBlock(error);
                                                    } else {
                                                        [[SHKActivityIndicator currentIndicator] displayCompleted:@"Connexion réussie"];
                                                        [self storeUserInfo:userInfo];
                                                        successBlock();
                                                    }
                                                }
                                                     onError:^(NSError* error) {
                                                         [[SHKActivityIndicator currentIndicator] displayCompleted:@"Erreur de connexion"];
                                                         errorBlock(error);
                                                     }];
}

/**
 * Login and store login data, then execute success block
 */
- (void)login:(NSString*)login 
     password:(NSString*)password 
     onSucess:(LoginSuccessBlock)successBlock 
      onError:(LoginFailedBlock)errorBlock
{
    [[SHKActivityIndicator currentIndicator] displayActivity:@"Connexion en cours"];
    [ApplicationDelegate.localisationEngine connectWithLogin:login
                                                    password:password 
                                                onCompletion:^(NSObject* userInfo) {
                                                    if (userInfo == nil) {
                                                        [[SHKActivityIndicator currentIndicator] displayCompleted:@"Erreur de connexion"];
                                                        NSError* error = [[NSError alloc] initWithDomain:@"myDomain" code:100 userInfo:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Erreur lors de la connexion",NSLocalizedDescriptionKey,nil]];
                                                        errorBlock(error);
                                                    } else {
                                                        [[SHKActivityIndicator currentIndicator] displayCompleted:@"Connexion réussie"];
                                                        [self storeUserInfo:userInfo];
                                                        successBlock();
                                                    }
                                                }
                                                     onError:^(NSError* error) {
                                                         [[SHKActivityIndicator currentIndicator] displayCompleted:@"Erreur de connexion"];
                                                         errorBlock(error);
                                                     }];
}

/**
 * Invalidate the access token and clear the cookie.
 */
- (void)logoutOnSucess:(LoginSuccessBlock)success 
               onError:(LoginFailedBlock)error
{
    [self cleanUserInfo];
    
    success();
}

/**
 * Show the fb authorization dialog.and set success block, will be executed in delegate after login succeded
 */
- (void)fbLoginOnSucess:(LoginSuccessBlock)success 
                onError:(LoginFailedBlock)error
{
    if (![facebook isSessionValid] || ![self isLogged]) {
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
- (void)cleanFbAuthData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
    [defaults removeObjectForKey:kSHKFacebookAccessTokenKey];
    [defaults removeObjectForKey:kSHKFacebookExpiryDateKey];
    [defaults removeObjectForKey:kSHKFacebookUserInfo];
    [defaults synchronize];
}

- (void)storeFbAuthData:(NSString *)accessToken expiresAt:(NSDate *)expiresAt
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:expiresAt forKey:@"FBExpirationDateKey"];
    [defaults setObject:accessToken forKey:kSHKFacebookAccessTokenKey];
	[defaults setObject:expiresAt forKey:kSHKFacebookExpiryDateKey];
    [defaults synchronize];
}

#pragma mark - FBSessionDelegate Methods

/**
 * Called when the user has logged in successfully.
 * store fb token, request user data via open graph, register user, then store user info if succeded.
 */
- (void)fbDidLogin
{
    [self storeFbAuthData:[facebook accessToken]
                expiresAt:[facebook expirationDate]];
    
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
        
        [[SHKActivityIndicator currentIndicator] displayActivity:@"Connexion en cours"];
        [ApplicationDelegate.localisationEngine registerWithName:name 
                                                        lastName:lastName 
                                                           login:login 
                                                        password:@"" 
                                                       birthDate:birthDate 
                                                      facebookId:fbId
                                                    facebookLink:fbLink
                                                    onCompletion:^(NSObject* userInfo) {
                                                        if (userInfo == nil) {
                                                            [[SHKActivityIndicator currentIndicator] displayCompleted:@"Erreur de connexion"];
                                                            NSError* error = [[NSError alloc] initWithDomain:@"myDomain" code:100 userInfo:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Erreur lors de la connexion via Facebook",NSLocalizedDescriptionKey,nil]];
                                                            loginfailedCallback(error);
                                                        } else {
                                                            [[SHKActivityIndicator currentIndicator] displayCompleted:@"Connexion réussie"];
                                                            [self storeUserInfo:userInfo];
                                                            loginSuccessCallback();
                                                        }
                                                    }
                                                         onError:^(NSError* error) {
                                                             [[SHKActivityIndicator currentIndicator] displayCompleted:@"Erreur de connexion"];
                                                             loginfailedCallback(error);
                                                         }];
        
    } andDidFail:^(FBRequest* request, NSError* error) {
                loginfailedCallback(error);
    }];
    
    if(loginSuccessCallback != nil && loginfailedCallback != nil) {
        [facebook requestWithGraphPath:@"me?fields=id,name,email,first_name,last_name,link,birthday" andDelegate:fbRequestHandler];
    }
}

-(void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt
{
    NSLog(@"token extended");
    [self storeFbAuthData:accessToken
                expiresAt:expiresAt];
}

/**
 * Called when the user canceled the authorization dialog.
 */
-(void)fbDidNotLogin:(BOOL)cancelled
{
    NSError* error = [[NSError alloc] initWithDomain:@"myDomain" code:100 userInfo:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Failed to login with facebook",NSLocalizedDescriptionKey,nil]];
    if(loginfailedCallback != nil) {
        loginfailedCallback(error);
    }
}

/**
 * Called when the request logout has succeeded.
 */
- (void)fbDidLogout
{
    [self cleanFbAuthData];
}

/**
 * Called when the session has expired.
 */
- (void)fbSessionInvalidated
{
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
