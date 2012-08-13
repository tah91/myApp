//
//  OffersSummary.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 01/08/12.
//
//

#import <Foundation/Foundation.h>
#import "Price.h"

typedef enum {
    os_meetingRoom,
    os_desktop
} offerSummary;

@interface OffersSummary : NSObject

@property (nonatomic) offerSummary      type;
@property (nonatomic,retain) Price*     minPrice;
@property (nonatomic,retain) NSArray*   offers;

-(id)initWithType:(offerSummary)type minPrice:(NSString*)price andOffers:(NSArray*)offers;

-(NSString*)getTitle:(BOOL)price;

@end
