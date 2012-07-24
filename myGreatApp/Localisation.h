//
//  Localisation.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"
#import "Price.h"
#import "Offer.h"
#import "OpeningTimes.h"
#import "Comment.h"
#import "Member.h"

@interface Localisation : Jastor

@property (nonatomic)       NSInteger   id;
@property (nonatomic, copy) NSString*   name;
@property (nonatomic, copy) NSNumber*   latitude;
@property (nonatomic, copy) NSNumber*   longitude;
@property (nonatomic, copy) NSString*   description;
@property (nonatomic, copy) NSString*   image;
@property (nonatomic, copy) NSString*   imageThumb;
@property (nonatomic, copy) NSString*   address;
@property (nonatomic, copy) NSString*   city;
@property (nonatomic, copy) NSNumber*   distance;
@property (nonatomic, copy) NSString*   type;
@property (nonatomic)       Boolean     isFree;
@property (nonatomic, copy) NSString*   url;
@property (nonatomic, copy) NSNumber*   rating;
@property (nonatomic, retain) Price*      prices;
@property (nonatomic, retain) OpeningTimes* openingTimes;
@property (nonatomic, retain) NSArray*  amenities;
@property (nonatomic, retain) NSArray*  offers;
@property (nonatomic, retain) NSArray*  comments;
@property (nonatomic, retain) NSArray*  fans;


@end
