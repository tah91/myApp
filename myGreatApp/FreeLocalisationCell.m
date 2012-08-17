//
//  FreeLocalisationCell.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 27/07/12.
//
//

#import "FreeLocalisationCell.h"
#import "SearchCriteria.h"
#import "UIView+TIAdditions.h"

@implementation FreeLocalisationCell

@synthesize wifiLogo,restoLogo,coffeeLogo,parkingLogo,handicapLogo;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelectedState:(BOOL)selected
{
    [super setSelectedState:selected];
}

-(void)setFieldsFromLoc:(Localisation*)loc
{
    if(![loc hasFeature:f_wifi_Free] && ![loc hasFeature:f_wifi_Not_Free]) {
        [self.wifiLogo setImage:[UIImage imageNamed:@"wifi-off.png"]];
        [self.wifiLogo setHighlightedImage:[UIImage imageNamed:@"wifi-off-sel.png"]];
    }
    if(![loc hasFeature:f_restauration]) {
        [self.restoLogo setImage:[UIImage imageNamed:@"resto-off.png"]];
        [self.restoLogo setHighlightedImage:[UIImage imageNamed:@"resto-off-sel.png"]];
    }
    if(![loc hasFeature:f_coffee]) {
        [self.coffeeLogo setImage:[UIImage imageNamed:@"coffee-off.png"]];
        [self.coffeeLogo setHighlightedImage:[UIImage imageNamed:@"coffee-off-sel.png"]];
    }
    if(![loc hasFeature:f_parking]) {
        [self.parkingLogo setImage:[UIImage imageNamed:@"parking-off.png"]];
        [self.parkingLogo setHighlightedImage:[UIImage imageNamed:@"parking-off-sel.png"]];
    }
    if(![loc hasFeature:f_handicap]) {
        [self.handicapLogo setImage:[UIImage imageNamed:@"handicap-off.png"]];
        [self.handicapLogo setHighlightedImage:[UIImage imageNamed:@"handicap-off-sel.png"]];
    }
    [super setFieldsFromLoc:loc];
}

@end
