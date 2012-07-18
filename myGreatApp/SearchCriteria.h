//
//  SearchCriteria.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    e_freeArea,
    e_buisnessLounge,
    e_workstation,
    e_desktop,
    e_meetingRoom,
    e_seminarRoom,
    e_visioRoom
} offerTypes;

typedef enum {
    e_wifiHotspot,
    e_cafeRestaurant,
    e_librairyMuseum,
    e_internetCafe,
    e_travelerLounge,
    e_hotel,
    e_telecentre,
    e_businessLounge,
    e_coworkingSpace,
    e_corporateCentre,
    e_privatePlace
} localisationTypes;

typedef enum {
    e_rating,
    e_distance, 
    e_price
} orderBy;

@interface SearchCriteria : NSObject

@property (strong, nonatomic)   NSString* place;
@property (strong, nonatomic)   NSString* name;
@property (nonatomic)           NSNumber* latitude;
@property (nonatomic)           NSNumber* longitude;
@property (strong, nonatomic)   NSString* offerType;
@property (strong, nonatomic)   NSString* types;
@property (strong, nonatomic)   NSString* features;
@property (nonatomic)           NSNumber* boundary;
@property (nonatomic)           NSInteger orderBy;
@property (nonatomic)           NSInteger maxCount;

@property (nonatomic) BOOL freePlace;
@property (nonatomic) BOOL desktop;
@property (nonatomic) BOOL meetingRoom;

-(id) initWithPlace:(NSString*)place;
-(NSMutableDictionary*) getParams;

@end