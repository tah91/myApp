//
//  SearchCriteria.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchCriteria.h"

@implementation SearchCriteria

@synthesize place,freePlace,desktop,meetingRoom;

-(id) initWithPlace:(NSString *)thePlace
{
    if (!(self = [super init]))
        return nil;
    
    self.place = thePlace;
    return self;
}

@end
