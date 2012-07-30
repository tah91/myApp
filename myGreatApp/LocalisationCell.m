//
//  ResultItemCell.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocalisationCell.h"

@implementation LocalisationCell

@synthesize nameLabel,distanceLabel,typeLabel,cityLabel,desktopPriceLabel,meetingPriceLabel,mainPic;
@synthesize locId;

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

-(void)setFieldsFromLoc:(Localisation*)loc {
    nameLabel.text = loc.name;
    distanceLabel.text = [loc getDistance];
    typeLabel.text = loc.type;
    cityLabel.text = loc.city;
    desktopPriceLabel.text = [loc getDesktopPrice];
    meetingPriceLabel.text = [loc getMeetingRoomPrice];
    mainPic.image = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:[loc getMainImage:true]]]];
    locId = loc.id;
}
@end
