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

@synthesize id,name,latitude,longitude,description,address,city,distance,type,isFree,url,rating,openingTimes,access,minPrices,images,features,offers,comments,fans;

@dynamic offerSummaries;

-(NSArray*) offerSummaries
{
    if(_offerSummaries != nil) {
        return _offerSummaries;
    }
    
    _offerSummaries = [NSMutableArray array];
    
    NSPredicate* hasMeetingRoom = [NSPredicate predicateWithFormat:@"(offerType ==  %d)", ot_meetingRoom];
    NSArray* meetingRoomPrices = [minPrices filteredArrayUsingPredicate:hasMeetingRoom];
    if([meetingRoomPrices count] != 0) {
        Price* meetingRoomPrice = [meetingRoomPrices objectAtIndex:0];
        NSArray* meetingRooms = [offers filteredArrayUsingPredicate:hasMeetingRoom];
        OffersSummary* toAdd = [[OffersSummary alloc] initWithType:os_meetingRoom minPrice:meetingRoomPrice.price andOffers:meetingRooms];
        [_offerSummaries addObject:toAdd];
    }
    
    NSPredicate* hasDesktop = [NSPredicate predicateWithFormat:@"(offerType IN  %@)", [NSArray arrayWithObjects:
                                                                                       [NSNumber numberWithInt:ot_desktop],
                                                                                       [NSNumber numberWithInt:ot_workstation],nil]];
    NSArray* desktopPrices = [minPrices filteredArrayUsingPredicate:hasDesktop];
    if([desktopPrices count] != 0) {
        Price* desktopPrice = [desktopPrices objectAtIndex:0];
        NSArray* desktops = [offers filteredArrayUsingPredicate:hasDesktop];
        OffersSummary* toAdd = [[OffersSummary alloc] initWithType:os_desktop minPrice:desktopPrice.price andOffers:desktops];
        [_offerSummaries addObject:toAdd];
    }
    
    return _offerSummaries;
}

+ (Class)minPrices_class
{
    return [MinPrice class];
}

+ (Class)images_class
{
    return [Image class];
}

+ (Class)features_class
{
    return [Feature class];
}

+ (Class)offers_class
{
    return [Offer class];
}

+ (Class)comments_class
{
    return [Comment class];
}

+ (Class)fans_class
{
    return [Member class];
}

-(NSString*)getMainImage:(BOOL)thumb
{
    if([images count] == 0) {
        return @"";
    }
    Image* first = [images objectAtIndex:0];
    return thumb ? first.thumbnail_url : first.url;
}

-(BOOL)hasFeature:(NSInteger)feature
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(featureId ==  %d)", feature];
    NSArray* filteredArray = [[self features] filteredArrayUsingPredicate:predicate];
    return [filteredArray count] != 0;
}

-(BOOL)hasMeetingRoom
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(type ==  %d)", os_meetingRoom];
    NSArray* filteredArray = [[self offerSummaries] filteredArrayUsingPredicate:predicate];
    return [filteredArray count] != 0;
}

-(void)getMeetingRoomPrice:(NSString**)price andDisplay:(NSString**)display
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(type ==  %d)", os_meetingRoom];
    NSArray* filteredArray = [[self offerSummaries] filteredArrayUsingPredicate:predicate];
    if([filteredArray count] == 0)
        return;
    
    OffersSummary* first = [filteredArray objectAtIndex:0];
    *price = [first.minPrice getDisplay];
    *display = [first getTitle:false];
}

-(BOOL)hasDesktop
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(type == %d)", os_desktop];
    NSArray* filteredArray = [[self offerSummaries] filteredArrayUsingPredicate:predicate];
    return [filteredArray count] != 0;
}

-(void)getDesktopPrice:(NSString**)price andDisplay:(NSString**)display
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(type == %d)",os_desktop];
    NSArray* filteredArray = [[self offerSummaries] filteredArrayUsingPredicate:predicate];
    if([filteredArray count] == 0)
        return;
    
    OffersSummary* first = [filteredArray objectAtIndex:0];
    *price = [first.minPrice getDisplay];
    *display = [first getTitle:false];
}

-(NSString*)getDistance
{
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt  setPositiveFormat:@"0.##"];
    return [NSString stringWithFormat:NSLocalizedString(@"%@ km",nil), [fmt stringFromNumber:distance]];
}

@end
