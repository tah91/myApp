//
//  Localisation.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"
#import "MinPrice.h"
#import "Offer.h"
#import "OpeningTimes.h"
#import "Comment.h"
#import "Member.h"
#import "Access.h"
#import "Image.h"
#import "Feature.h"
#import "OffersSummary.h"

@interface Localisation : Jastor {
    NSMutableArray* _offerSummaries;
}

@property (nonatomic)       NSInteger   id;
@property (nonatomic, copy) NSString*   name;
@property (nonatomic, copy) NSNumber*   latitude;
@property (nonatomic, copy) NSNumber*   longitude;
@property (nonatomic, copy) NSString*   description;
@property (nonatomic, copy) NSString*   address;
@property (nonatomic, copy) NSString*   city;
@property (nonatomic, copy) NSNumber*   distance;
@property (nonatomic, copy) NSString*   type;
@property (nonatomic)       BOOL        isFree;
@property (nonatomic, copy) NSString*   url;
@property (nonatomic, copy) NSNumber*   rating;
@property (nonatomic, retain) OpeningTimes* openingTimes;
@property (nonatomic, retain) Access* access;
@property (nonatomic, retain) NSArray*  minPrices;
@property (nonatomic, retain) NSArray*  images;
@property (nonatomic, retain) NSArray*  features;
@property (nonatomic, retain) NSArray*  offers;
@property (nonatomic, retain) NSArray*  comments;
@property (nonatomic, retain) NSArray*  fans;
@property (nonatomic, retain, readonly) NSArray*  offerSummaries;

-(NSString*)getMainImage:(BOOL)thumb;
-(BOOL)hasMeetingRoom;
-(void)getMeetingRoomPrice:(NSString**)price andDisplay:(NSString**)display;
-(BOOL)hasDesktop;
-(void)getDesktopPrice:(NSString**)price andDisplay:(NSString**)display;
-(NSString*)getDistance;

@end
