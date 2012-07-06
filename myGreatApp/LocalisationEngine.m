//
//  LocalisationEngine.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocalisationEngine.h"

#define EWORKY_URL(__C1__) [NSString stringWithFormat:@"api/localisation/search?place=%@&json=1", __C1__]

@implementation LocalisationEngine

-(MKNetworkOperation*) placeToSeach:(NSString*) place 
                       onCompletion:(LocalisationResponseBlock) completionBlock
                            onError:(MKNKErrorBlock) errorBlock {
    
    MKNetworkOperation *op = [self operationWithPath:EWORKY_URL(place) 
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

@end
