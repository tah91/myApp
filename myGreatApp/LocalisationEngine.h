//
//  LocalisationEngine.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define SEARCH_URL @"api/localisation/search"
#define DETAILS_URL @"api/localisation/details"
#define LOGIN_URL @"api/account/login"
#define REGISTER_URL @"api/account/register"
#define EDIT_INFO_URL @"api/account/editInfo"
#define EDIT_PASSWORD_URL @"api/account/editPassword"

#import "MKNetworkEngine.h"
#import "SearchCriteria.h"

@interface LocalisationEngine : MKNetworkEngine

typedef void (^SearchResponseBlock)(NSMutableArray* localisations);
typedef void (^LocalisationResponseBlock)(NSObject* localisation);
typedef void (^LoginResponseBlock)(NSObject* userInfo);

-(MKNetworkOperation*) searchWithCriteria:(SearchCriteria*) criteria 
                             onCompletion:(SearchResponseBlock) completion
                                  onError:(MKNKErrorBlock) error;

-(MKNetworkOperation*) detailsWithId:(NSNumber*) locId 
                        onCompletion:(LocalisationResponseBlock) completion
                             onError:(MKNKErrorBlock) error;

-(MKNetworkOperation*) enqueueOperationWithUrl:(NSString*)url
                                        params:(NSMutableDictionary*) params
                                    httpMethod:(NSString*)httpMethod
                                    onCompletion:(LoginResponseBlock) completionBlock
                                        onError:(MKNKErrorBlock) errorBlock;

-(MKNetworkOperation*) registerWithName:(NSString*) name
                               lastName:(NSString*) lastName 
                                  login:(NSString*) login
                               password:(NSString*) password
                              birthDate:(NSString*) date
                             facebookId:(NSNumber*) fbId
                           facebookLink:(NSString*) fbLink
                           onCompletion:(LoginResponseBlock) completionBlock
                                onError:(MKNKErrorBlock) errorBlock;

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
