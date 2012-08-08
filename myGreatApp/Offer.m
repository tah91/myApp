//
//  Offer.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 23/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Offer.h"

@implementation Offer

@synthesize id,name,images,prices,features,availability,offerType;

+ (Class)pictures_class {
    return [Image class];
}

+ (Class)prices_class {
    return [Price class];
}

+ (Class)features_class {
    return [Feature class];
}

@end
