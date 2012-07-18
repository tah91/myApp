//
//  FBSession.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBConnect.h"
#import "FBRequestBlockDelegate.h"

typedef void (^LoginSuccessBlock)();
typedef void (^LoginFailedBlock)(NSError* error);

@interface LoginSession : NSObject <FBSessionDelegate>

@property (nonatomic, retain) Facebook* facebook;

-(id) initWithId:(NSString*)appId;

- (BOOL)isLogged;
- (void)registerWithName:(NSString*)name 
                lastName:(NSString*)lastName 
                   login:(NSString*)login 
                password:(NSString*)password 
                onSucess:(LoginSuccessBlock)success 
                 onError:(LoginFailedBlock)error;
- (void)login:(NSString*)login
     password:(NSString*)password
     onSucess:(LoginSuccessBlock)success
      onError:(LoginFailedBlock)error;
- (void)logoutOnSucess:(LoginSuccessBlock)success onError:(LoginFailedBlock)error;
- (void)fbLoginOnSucess:(LoginSuccessBlock)success onError:(LoginFailedBlock)error;
- (void)fbLogout;

@property (nonatomic, copy) LoginSuccessBlock loginSuccessCallback;
@property (nonatomic, copy) LoginFailedBlock loginfailedCallback;

@property (nonatomic, copy) FBRequestBlockDelegate* fbRequestHandler;

@end 
