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

- (id)initWithName:(NSString*)name address:(NSString*)theAddress coordinate:(CLLocationCoordinate2D)theCoordinate localisation:(Localisation*)theLoc {
    if ((self = [super init])) {
        self.title = [name copy];
        self.subtitle = [theAddress copy];
        self.coordinate = theCoordinate;
        self.localisation = localisation;
    }
    return self;
}

@end
