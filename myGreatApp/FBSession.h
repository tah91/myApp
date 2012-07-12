//
//  FBSession.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBConnect.h"

@interface FBSession : NSObject <FBSessionDelegate>

@property (nonatomic, retain) Facebook* facebook;

-(id) initWithId:(NSString*)appId;

- (BOOL)isLogged;
- (void)login;
- (void)logout;

@end
