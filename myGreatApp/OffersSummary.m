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

-(NSString*)getTitle:(BOOL)price {
    NSString* toRet = @"";
    switch (type) {
        case os_meetingRoom:
            toRet = [toRet stringByAppendingString:NSLocalizedString(@"Salle de réunion",nil)];
            break;
        case os_desktop:
            toRet = [toRet stringByAppendingString:NSLocalizedString(@"Bureau",nil)];
            break;
        default:
            break;
    }
    
    if([minPrice.price length] != 0) {
        //toRet = [toRet stringByAppendingFormat:NSLocalizedString(@" dès %@",nil),minPrice.price];
        toRet = price ? [toRet stringByAppendingFormat:NSLocalizedString(@" dès %@",nil),minPrice.price] : [toRet stringByAppendingString:NSLocalizedString(@" dès",nil)];
    }
    
    return toRet;
}

@end
