//
//  LocalisationEngine.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocalisationEngine.h"
#import "Meta.h"
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

-(MKNetworkOperation*) enqueueOperationWithUrl:(NSString*)url
                                        params:(NSMutableDictionary*) params
                                    httpMethod:(NSString*)httpMethod
                                  onCompletion:(LoginResponseBlock) completionBlock
                                       onError:(MKNKErrorBlock) errorBlock
{
    
    MKNetworkOperation *op = [self operationWithPath:url
                                              params:params 
                                          httpMethod:httpMethod];
    
    [op onCompletion:^(MKNetworkOperation *completedOperation)
     {
         NSDictionary *response = [completedOperation responseJSON];
         NSDictionary* meta = [response objectForKey:@"meta"];
         Meta* metaObj = [[Meta alloc] initWithDictionary:meta];
         if(metaObj.statusCode == 200) {
             NSObject* res = [response objectForKey:@"response"];
             completionBlock(res);
         } else {
             NSError* error = [[NSError alloc] initWithDomain:@"myDomain" code:100 userInfo:[[NSMutableDictionary alloc] initWithObjectsAndKeys:metaObj.message,NSLocalizedDescriptionKey,nil]];
             errorBlock(error);
         }
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
    
    return [self enqueueOperationWithUrl:REGISTER_URL params:params httpMethod:@"POST" onCompletion:completionBlock onError:errorBlock];
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
    
    return [self enqueueOperationWithUrl:REGISTER_URL params:params httpMethod:@"POST" onCompletion:completionBlock onError:errorBlock];
}

-(MKNetworkOperation*) connectWithLogin:(NSString*) login
                               password:(NSString*) password 
                           onCompletion:(LoginResponseBlock) completionBlock
                                onError:(MKNKErrorBlock) errorBlock
{
    MKNetworkOperation *op = [self operationWithPath:LOGIN_URL
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
