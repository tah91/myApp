//
//  Localisation.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Libraries/Jastor/Jastor.h"

@interface Localisation : Jastor

@property (nonatomic) NSInteger id;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* city;
@property (nonatomic, copy) NSNumber* latitude;
@property (nonatomic, copy) NSNumber* longitude;

@end
