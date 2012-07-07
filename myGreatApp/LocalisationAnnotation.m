//
//  LocalisationAnnotation.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 07/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocalisationAnnotation.h"

@implementation LocalisationAnnotation

@synthesize coordinate, title, subtitle, locId;

- (id)initWithName:(NSString*)name address:(NSString*)theAddress coordinate:(CLLocationCoordinate2D)theCoordinate locId:(NSInteger)theId {
    if ((self = [super init])) {
        title = [name copy];
        subtitle = [theAddress copy];
        coordinate = theCoordinate;
        locId = theId;
    }
    return self;
}

@end
