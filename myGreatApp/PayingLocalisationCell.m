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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animate
{
    UIColor * newShadow = highlighted ? [UIColor blackColor] : [UIColor whiteColor];
    
    desktopLabel.shadowColor = newShadow;
    desktopPriceLabel.shadowColor = newShadow;
    meetingPriceLabel.shadowColor = newShadow;
    meetingLabel.shadowColor = newShadow;
    
    [super setHighlighted:highlighted animated:animate];
}

-(void)setFieldsFromLoc:(Localisation*)loc {
    [super setFieldsFromLoc:loc];
    
    NSString* meetingPrice = @"";
    NSString* meetingDisplay = @"";
    NSString* desktopPrice = @"";
    NSString* desktopDisplay = @"";
    
    [loc getDesktopPrice:&desktopPrice andDisplay:&desktopDisplay];
    [loc getMeetingRoomPrice:&meetingPrice andDisplay:&meetingDisplay];
    
    [self setLabel:desktopLabel
          withText:[NSString stringWithFormat:@"%@ %@",desktopDisplay,desktopPrice]
          andColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    
    [self setLabel:meetingLabel
          withText:[NSString stringWithFormat:@"%@ %@",meetingDisplay,meetingPrice]
          andColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    
    /*[self setLabel:desktopPriceLabel
          withText:desktopPrice
          andColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    
    [self setLabel:meetingPriceLabel
          withText:meetingPrice
          andColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];*/
}

@end
