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

-(MKNetworkOperation*) placeToSeach:(NSString*) place 
                       onCompletion:(LocalisationResponseBlock) completion
                            onError:(MKNKErrorBlock) error;

@end
