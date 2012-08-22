//
//  LocalisationEngine.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocalisationEngine.h"

#define SEARCH_URL @"api/localisation/search"
#define DETAILS_URL @"api/localisation/details"
#define LOGIN_URL @"api/account/login"
#define REGISTER_URL @"api/account/register"

@implementation LocalisationEngine

-(MKNetworkOperation*) searchWithCriteria:(SearchCriteria*) criteria 
                             onCompletion:(SearchResponseBlock) completionBlock
                                  onError:(MKNKErrorBlock) errorBlock
{
    
    MKNetworkOperation *op = [self operationWithPath:SEARCH_URL
                                              params:[criteria getParams]
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

-(MKNetworkOperation*) detailsWithId:(NSNumber*) locId 
                        onCompletion:(LocalisationResponseBlock) completionBlock
                             onError:(MKNKErrorBlock) errorBlock
{
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   locId,@"id",
                                   nil];
    
    MKNetworkOperation *op = [self operationWithPath:DETAILS_URL
                                              params:params
                                          httpMethod:@"GET"];
    
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

-(MKNetworkOperation*) registerWithParams:(NSMutableDictionary*) params
                             onCompletion:(LoginResponseBlock) completionBlock
                                  onError:(MKNKErrorBlock) errorBlock
{
    
    MKNetworkOperation *op = [self operationWithPath:REGISTER_URL
                                              params:params 
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

-(MKNetworkOperation*) registerWithName:(NSString*) name
                               lastName:(NSString*) lastName 
                                  login:(NSString*) login
                               password:(NSString*) password
                              birthDate:(NSString*) date
                             facebookId:(NSNumber*) fbId
                           facebookLink:(NSString*) fbLink
                           onCompletion:(LoginResponseBlock) completionBlock
                                onError:(MKNKErrorBlock) errorBlock
{
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   name,@"firstName",
                                   lastName,@"lastName",
                                   login,@"email",
                                   password,@"password",
                                   date,@"birthDate",
                                   fbId,@"facebookId",
                                   fbLink,@"facebookLink",
                                   nil];
    
    return [self registerWithParams:params onCompletion:completionBlock onError:errorBlock];
}

-(MKNetworkOperation*) registerWithName:(NSString*) name
                               lastName:(NSString*) lastName 
                                  login:(NSString*) login
                               password:(NSString*) password
                           onCompletion:(LoginResponseBlock) completionBlock
                                onError:(MKNKErrorBlock) errorBlock
{
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   name,@"firstName",
                                   lastName,@"lastName",
                                   login,@"email",
                                   password,@"password",
                                   nil];
    
    return [self registerWithParams:params onCompletion:completionBlock onError:errorBlock];
}

-(MKNetworkOperation*) connectWithLogin:(NSString*) login
                               password:(NSString*) password 
                           onCompletion:(LoginResponseBlock) completionBlock
                                onError:(MKNKErrorBlock) errorBlock
{
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   login,@"email",
                                   password,@"password",
                                   nil];
    
    return [self registerWithParams:params onCompletion:completionBlock onError:errorBlock];
    
    MKNetworkOperation *op = [self operationWithPath:REGISTER_URL
                                              params:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                      login,@"login",
                                                      password,@"password",
                                                      nil]
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
