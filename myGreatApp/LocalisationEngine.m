//
//  LocalisationEngine.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocalisationEngine.h"

#define SEARCH_URL(__C1__) [NSString stringWithFormat:@"api/localisation/search?place=%@&json=1", __C1__]
#define LOGIN_URL @"api/localisation/connect&json=1"
#define REGISTER_URL @"api/localisation/register&json=1"

@implementation LocalisationEngine

-(MKNetworkOperation*) placeToSeach:(NSString*) place 
                       onCompletion:(LocalisationResponseBlock) completionBlock
                            onError:(MKNKErrorBlock) errorBlock {
    
    MKNetworkOperation *op = [self operationWithPath:SEARCH_URL(place) 
                                              params:nil 
                                          httpMethod:@"GET"];
    
    [op onCompletion:^(MKNetworkOperation *completedOperation)
     {
         NSDictionary *response = [completedOperation responseJSON];
         NSMutableArray* res = [response objectForKey:@"response"];
         completionBlock(res);
         
     }onError:^(NSError* error) {
         errorBlock(error);
     }];
    
    [self enqueueOperation:op];
    
    return op;
}

-(MKNetworkOperation*) registerWithName:(NSString*) name
                               lastName:(NSString*) lastName 
                                  login:(NSString*) login
                               password:(NSString*) password 
                           onCompletion:(LoginResponseBlock) completionBlock
                                onError:(MKNKErrorBlock) errorBlock {
    MKNetworkOperation *op = [self operationWithPath:REGISTER_URL
                                              params:nil 
                                          httpMethod:@"POST"];
    
    [op onCompletion:^(MKNetworkOperation *completedOperation)
     {
         NSDictionary *response = [completedOperation responseJSON];
         NSObject* res = [response objectForKey:@"response"];
         completionBlock(res);
         
     }onError:^(NSError* error) {
         errorBlock(error);
     }];
    
    [self enqueueOperation:op];
    
    return op;
}

-(MKNetworkOperation*) connectWithLogin:(NSString*) login
                               password:(NSString*) password 
                           onCompletion:(LoginResponseBlock) completionBlock
                                onError:(MKNKErrorBlock) errorBlock {
    MKNetworkOperation *op = [self operationWithPath:REGISTER_URL
                                              params:nil 
                                          httpMethod:@"POST"];
    
    [op onCompletion:^(MKNetworkOperation *completedOperation)
     {
         NSDictionary *response = [completedOperation responseJSON];
         NSObject* res = [response objectForKey:@"response"];
         completionBlock(res);
         
     }onError:^(NSError* error) {
         errorBlock(error);
     }];
    
    [self enqueueOperation:op];
    
    return op;
}

@end
