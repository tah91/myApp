//
//  FreeLocalisationCell.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 27/07/12.
//
//

#import "FreeLocalisationCell.h"

@implementation FreeLocalisationCell

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
    [super setFieldsFromLoc:loc];
}

@end
