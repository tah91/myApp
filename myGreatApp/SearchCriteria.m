//
//  SearchCriteria.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchCriteria.h"

@implementation SearchCriteria

@synthesize place,name,latitude,longitude,offerType,types,features,boundary,orderBy,maxCount,freePlace,desktop,meetingRoom;

-(id) init {
    if (!(self = [super init]))
        return nil;
    
    [self setPlace:@""];
    [self setName:@""];
    [self setLatitude:[NSNumber numberWithInt:0]];
    [self setLongitude:[NSNumber numberWithInt:0]];
    [self setOfferType:@""];
    [self setTypes:@""];
    [self setFeatures:@""];
    [self setBoundary:[NSNumber numberWithInt:5]];
    [self setMaxCount:30];
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

-(NSMutableDictionary*) getParams {
    NSMutableArray* offerTypes = [NSMutableArray array];
    if(freePlace) {
        [offerTypes addObject:[NSString stringWithFormat:@"%d", ot_freeArea]];
    }
    if(desktop) {
        [offerTypes addObject:[NSString stringWithFormat:@"%d", ot_desktop]];
        [offerTypes addObject:[NSString stringWithFormat:@"%d", ot_workstation]];
    }
    if(meetingRoom) {
        [offerTypes addObject:[NSString stringWithFormat:@"%d", ot_meetingRoom]];
    }
    offerType = [NSString stringWithFormat:@"[%@]",[offerTypes componentsJoinedByString:@","]];
    NSArray* keys = [NSArray arrayWithObjects:@"place", @"name", @"latitude", @"longitude", @"offerType", @"types", @"features", @"boundary", @"orderBy", @"maxCount", nil];
    NSMutableDictionary* properties = [[NSMutableDictionary alloc] initWithDictionary:[self dictionaryWithValuesForKeys:keys]];
    return properties;
}

@end
