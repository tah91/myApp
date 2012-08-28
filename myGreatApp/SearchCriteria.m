//
//  SearchCriteria.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchCriteria.h"

@implementation SearchCriteria

@synthesize place,name,latitude,longitude,offerTypes,types,features,boundary,orderBy,freePlace,desktop,meetingRoom,page,neLat,neLng,swLat,swLng;

-(id) init {
    if (!(self = [super init]))
        return nil;
    
    [self setPlace:@""];
    [self setName:@""];
    [self setLatitude:[NSNumber numberWithInt:0]];
    [self setLongitude:[NSNumber numberWithInt:0]];
    [self setNeLat:[NSNumber numberWithInt:0]];
    [self setNeLng:[NSNumber numberWithInt:0]];
    [self setSwLat:[NSNumber numberWithInt:0]];
    [self setSwLng:[NSNumber numberWithInt:0]];
    [self setOfferTypes:@""];
    [self setTypes:@""];
    [self setFeatures:@""];
    [self setBoundary:[NSNumber numberWithInt:1]];
    [self setPage:1];
    [self setOrderBy:ob_distance];
    [self setFreePlace:false];
    [self setDesktop:false];
    [self setMeetingRoom:false];
    
    return self;
}

-(id) initWithPlace:(NSString *)thePlace
{
    if (!(self = [self init]))
        return nil;
    
    [self setPlace:thePlace];
    
    return self;
}

-(id) initWithName:(NSString *)theName
{
    if (!(self = [self init]))
        return nil;
    
    [self setName:theName];
    
    return self;
}

-(id) initWithLatitude:(NSNumber *)lat andLongitude:(NSNumber*)lng
{
    if (!(self = [self init]))
        return nil;
    
    [self setLatitude:lat];
    [self setLongitude:lng];

    return self;
}


-(NSMutableDictionary*) getParams {
    NSMutableArray* offerTypesArray = [NSMutableArray array];
    if(freePlace) {
        [offerTypesArray addObject:[NSString stringWithFormat:@"%d", ot_freeArea]];
    }
    if(desktop) {
        [offerTypesArray addObject:[NSString stringWithFormat:@"%d", ot_desktop]];
        [offerTypesArray addObject:[NSString stringWithFormat:@"%d", ot_workstation]];
    }
    if(meetingRoom) {
        [offerTypesArray addObject:[NSString stringWithFormat:@"%d", ot_meetingRoom]];
    }
    self.offerTypes = [NSString stringWithFormat:@"[%@]",[offerTypesArray componentsJoinedByString:@","]];
    NSArray* keys = [NSArray arrayWithObjects:@"place", @"name", @"latitude", @"longitude", @"neLat", @"neLng", @"swLat", @"swLng", @"offerTypes", @"types", @"features", @"boundary", @"orderBy", @"page", nil];
    NSMutableDictionary* properties = [[NSMutableDictionary alloc] initWithDictionary:[self dictionaryWithValuesForKeys:keys]];
    return properties;
}

@end
