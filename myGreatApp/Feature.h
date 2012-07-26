//
//  Feature.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 26/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

@interface Feature : Jastor

@property (nonatomic) NSInteger         featureId;
@property (nonatomic,copy) NSString*    featureDisplay;

@end
