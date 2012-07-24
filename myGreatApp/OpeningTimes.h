//
//  OpeningTimes.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 23/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

@interface OpeningTimes : Jastor

@property (nonatomic,copy) NSString* monday;
@property (nonatomic,copy) NSString* tuesday;
@property (nonatomic,copy) NSString* wednesday;
@property (nonatomic,copy) NSString* thursday;
@property (nonatomic,copy) NSString* friday;
@property (nonatomic,copy) NSString* saturday;
@property (nonatomic,copy) NSString* sunday;

@end
