//
//  Offer.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 23/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

@interface Offer : Jastor

@property (nonatomic) NSInteger         id;
@property (nonatomic,copy) NSString*    name;
@property (nonatomic, retain) NSArray*  pictures;
@property (nonatomic, retain) NSArray*  prices;
@property (nonatomic, retain) NSArray*  amenities;
@property (nonatomic,copy) NSString*    availability;
@property (nonatomic) NSInteger         type;

@end
