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

-(id) initWithPlace:(NSString *)thePlace
{
    if (!(self = [super init]))
        return nil;
    
    self.place = thePlace;
    return self;
}

-(NSMutableDictionary*) getParams {
    NSMutableArray* offerTypes = [[NSMutableArray alloc] init];
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
    NSMutableDictionary* properties = [[NSMutableDictionary alloc] initWithDictionary:[self dictionaryWithValuesForKeys:[[NSArray alloc] initWithObjects:@"place",@"offerType", nil]]];
    return properties;
}

@end
