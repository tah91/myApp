//
//  Localisation.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Localisation.h"
#import "SearchCriteria.h"

@implementation Localisation

@synthesize id,name,latitude,longitude,description,address,city,distance,type,isFree,url,rating,openingTimes,access,prices,images,features,offers,comments,fans;

+ (Class)prices_class {
    return [Price class];
}

+ (Class)images_class {
    return [Image class];
}

+ (Class)features_class {
    return [Feature class];
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

-(NSString*)getMainImage:(BOOL)thumb {
    if([images count] == 0) {
        return @"";
    }
    Image* first = [images objectAtIndex:0];
    return thumb ? first.thumbnail_url : first.url;
}

-(BOOL)hasMeetingRoom {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(offerType ==  %d)", ot_meetingRoom];
    NSArray* filteredArray = [prices filteredArrayUsingPredicate:predicate];
    return [filteredArray count] != 0;
}

-(NSString *)getMeetingRoomPrice {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(offerType ==  %d)", ot_meetingRoom];
    NSArray* filteredArray = [prices filteredArrayUsingPredicate:predicate];
    if([filteredArray count] == 0)
        return @"";
    
    Price* first = [filteredArray objectAtIndex:0];
    return first.price;
}

-(BOOL)hasDesktop {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(offerType IN  %@)", [NSArray arrayWithObjects:
                                                                                      [NSNumber numberWithInt:ot_desktop],
                                                                                      [NSNumber numberWithInt:ot_workstation],nil]];
    NSArray* filteredArray = [prices filteredArrayUsingPredicate:predicate];
    return [filteredArray count] != 0;
}

-(NSString*)getDesktopPrice {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(offerType IN  %@)",[NSArray arrayWithObjects:
                                                                                     [NSNumber numberWithInt:ot_desktop],
                                                                                     [NSNumber numberWithInt:ot_workstation],nil]];
    NSArray* filteredArray = [prices filteredArrayUsingPredicate:predicate];
    if([filteredArray count] == 0)
        return @"";
    
    Price* first = [filteredArray objectAtIndex:0];
    return first.price;
}

-(NSString*)getDistance {
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt  setPositiveFormat:@"0.##"];
    return [NSString stringWithFormat:@"%@ kms", [fmt stringFromNumber:distance]];
}

@end
