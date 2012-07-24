//
//  Localisation.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Localisation.h"

@implementation Localisation

@synthesize id,name,latitude,longitude,description,image,imageThumb,address,city,distance,type,isFree,url,rating,prices,openingTimes,amenities,offers,comments,fans;

+ (Class)amenities_class {
    return [NSString class];
}

+ (Class)offers_class {
    return [Offer class];
}

+ (Class)comments_class {
    return [Comment class];
}

+ (Class)fans_class {
    return [Member class];
}
@end
