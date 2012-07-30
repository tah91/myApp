//
//  FreeLocalisationCell.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 27/07/12.
//
//

#import "FreeLocalisationCell.h"

@implementation FreeLocalisationCell

@synthesize nameLabel,distanceLabel,typeLabel,cityLabel,featureLabel,mainPic;
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
    featureLabel.text = [loc getDesktopPrice];
    mainPic.image = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:[loc getMainImage:true]]]];
    locId = loc.id;
}

@end
