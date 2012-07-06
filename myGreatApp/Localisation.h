//
//  Localisation.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSKeyValueCoding.h>
#import "Jastor.h"

@interface Localisation : Jastor

@property int id;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* city;

@end
