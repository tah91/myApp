//
//  ResultItemCell.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PayingLocalisationCell.h"

@implementation PayingLocalisationCell

@synthesize desktopPriceLabel,meetingPriceLabel,desktopLabel,desktopPic,meetingLabel,meetingPic;

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
    UIColor * newShadow = selected ? [UIColor blackColor] : [UIColor whiteColor];
    
    desktopLabel.shadowColor = newShadow;
    meetingLabel.shadowColor = newShadow;
    
    [super setSelectedState:selected];
}

-(void)setFieldsFromLoc:(Localisation*)loc
{
    [super setFieldsFromLoc:loc];
    
    NSString* meetingPrice = @"";
    NSString* meetingDisplay = @"";
    NSString* desktopPrice = @"";
    NSString* desktopDisplay = @"";
    
    [loc getDesktopPrice:&desktopPrice andDisplay:&desktopDisplay];
    [loc getMeetingRoomPrice:&meetingPrice andDisplay:&meetingDisplay];
    
    if([desktopDisplay length] == 0) {
        [self.desktopPic setImage:[UIImage imageNamed:@"desktop-off.png"]];
        [self.desktopPic setHighlightedImage:[UIImage imageNamed:@"desktop-off-sel.png"]];
    }
    
    if([meetingDisplay length] == 0) {
        [self.meetingPic setImage:[UIImage imageNamed:@"meeting-off.png"]];
        [self.meetingPic setHighlightedImage:[UIImage imageNamed:@"meeting-off-sel.png"]];
    }
    
    [self setLabel:desktopLabel
          withText:[NSString stringWithFormat:@"%@ %@",desktopDisplay,desktopPrice]
          andColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    
    [self setLabel:meetingLabel
          withText:[NSString stringWithFormat:@"%@ %@",meetingDisplay,meetingPrice]
          andColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
}

@end