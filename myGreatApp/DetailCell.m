//
//  DetailCell.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 15/08/12.
//
//

#import "DetailCell.h"
#import "UIView+TIAdditions.h"

@implementation DetailCell

@synthesize titleLabel, descriptionLabel;

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

    if(selected) {
        [self setBackgroundColor:GROUPED_BNG_SEL];
        [[self titleLabel] setTextColor:WHITE_COLOR];
        if(self.accessoryView != nil) {
            [self setAccessoryView:[[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"accessory-sel.png" ]]];
        }
    } else {
        CGSize imgSize = self.frame.size;
        [self setBackgroundColor:GROUPED_BNG(imgSize)];
        [[self titleLabel] setTextColor:GREY_COLOR];
        if(self.accessoryView != nil) {
            [self setAccessoryView:[[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"accessory.png" ]]];
        }
    }
}

@end