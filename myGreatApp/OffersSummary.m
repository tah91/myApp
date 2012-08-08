//
//  OffersSummary.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 01/08/12.
//
//

#import "OffersSummary.h"

@implementation OffersSummary

@synthesize type,minPrice,offers;

-(id)initWithType:(offerSummary)aType minPrice:(Price*)price andOffers:(NSArray*)someOffers {
    if (!(self = [super init]))
        return nil;
    
    [self setType:aType];
    [self setMinPrice:price];
    [self setOffers:someOffers];
    
    return self;
}

-(NSString*)getTitle {
    NSString* toRet = @"";
    switch (type) {
        case os_meetingRoom:
            toRet = [toRet stringByAppendingString:@"Salle de réunion"];
            break;
        case os_desktop:
            toRet = [toRet stringByAppendingString:@"Bureau"];
            break;
        default:
            break;
    }
    
    if([minPrice.price length] != 0) {
        //toRet = [toRet stringByAppendingFormat:@" dès %@",minPrice.price];
        toRet = [toRet stringByAppendingString:@" dès"];
    }
    
    return toRet;
}

@end
