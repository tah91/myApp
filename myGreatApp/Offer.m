//
//  Offer.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 23/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Offer.h"

@implementation Offer

@synthesize id,name,pictures,prices,amenities,availability,type;

+ (Class)pictures_class {
    return [NSString class];
}

+ (Class)prices_class {
    return [NSString class];
}

+ (Class)amenities_class {
    return [NSString class];
}

@end
