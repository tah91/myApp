//
//  LocalisationEngine.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MKNetworkEngine.h"

@interface LocalisationEngine : MKNetworkEngine

typedef void (^LocalisationResponseBlock)(NSMutableArray* localisations);
typedef void (^LoginResponseBlock)(NSObject* userInfo);

-(MKNetworkOperation*) placeToSeach:(NSString*) place 
                       onCompletion:(LocalisationResponseBlock) completion
                            onError:(MKNKErrorBlock) error;

-(MKNetworkOperation*) registerWithName:(NSString*) name
                               lastName:(NSString*) lastName 
                                  login:(NSString*) login
                               password:(NSString*) password 
                           onCompletion:(LoginResponseBlock) completion
                                onError:(MKNKErrorBlock) error;

-(MKNetworkOperation*) connectWithLogin:(NSString*) login
                               password:(NSString*) password 
                           onCompletion:(LoginResponseBlock) completion
                                onError:(MKNKErrorBlock) error;

@end
