//
//  LocalisationEngine.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define SEARCH_URL @"api/localisation/search"
#define DETAILS_URL @"api/localisation/details"
#define ADD_TO_FAV_URL @"api/localisation/addtofavorites"
#define COMMENT_URL @"api/localisation/comment"
#define LOGIN_URL @"api/account/login"
#define REGISTER_URL @"api/account/register"
#define EDIT_INFO_URL @"api/account/editInfo"
#define EDIT_PASSWORD_URL @"api/account/editPassword"

#import "MKNetworkEngine.h"
#import "SearchCriteria.h"

@interface LocalisationEngine : MKNetworkEngine

typedef void (^OperationResponseBlock)(NSObject* userInfo);

-(MKNetworkOperation*) enqueueOperationWithUrl:(NSString*)url
                                        params:(NSMutableDictionary*) params
                                    httpMethod:(NSString*)httpMethod
                                  onCompletion:(OperationResponseBlock) completionBlock
                                       onError:(MKNKErrorBlock) errorBlock;

@end
