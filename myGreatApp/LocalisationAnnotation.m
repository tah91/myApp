//
//  LocalisationAnnotation.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 07/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocalisationAnnotation.h"

@implementation LocalisationAnnotation

@synthesize coordinate, title, subtitle, localisation;

- (id)initWithId:(NSInteger)theId name:(NSString*)theName address:(NSString*)theAddress coordinate:(CLLocationCoordinate2D)theCoordinate localisation:(Localisation*)theLoc {
    if ((self = [super init])) {
        self.locId = theId;
        self.title = theName;
        self.subtitle = theAddress;
        self.coordinate = theCoordinate;
        self.localisation = localisation;
    }
    return self;
}

- (id)copy
{
    return [super copy];
}

- (id)init
{
    return [super init];
}

- (id)mutableCopy
{
    return [super mutableCopy];
}

@end
