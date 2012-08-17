//
//  FeatureCell.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 16/08/12.
//
//

#import "FeatureCell.h"

@implementation FeatureCell

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

    [[self featureLabel] setTextColor:GREY_COLOR];
}

@end
