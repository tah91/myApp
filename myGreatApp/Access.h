//
//  Access.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 26/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

@interface Access : Jastor

@property (nonatomic,copy) NSString* publicTransport;
@property (nonatomic,copy) NSString* station;
@property (nonatomic,copy) NSString* roadAccess;

@end
