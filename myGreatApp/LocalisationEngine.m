//
//  LocalisationEngine.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocalisationEngine.h"
#import "Meta.h"
#import "NSDate+TIAdditions.h"

@implementation LocalisationEngine

-(MKNetworkOperation*) enqueueOperationWithUrl:(NSString*)url
                                        params:(NSMutableDictionary*) params
                                    httpMethod:(NSString*)httpMethod
                                  onCompletion:(OperationResponseBlock) completionBlock
                                       onError:(MKNKErrorBlock) errorBlock
{
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    [params trySetObject:language forKey:@"locale-culture"];
    
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

@end
