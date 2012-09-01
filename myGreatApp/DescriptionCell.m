//
//  DescriptionCell.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 01/09/12.
//
//

#import "DescriptionCell.h"
#import "UIView+TIAdditions.h"

@implementation DescriptionCell

@synthesize descriptionLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setSelectedState:(BOOL)selected
{
    CGSize imgSize = self.frame.size;
    [self setBackgroundColor:GROUPED_BNG(imgSize)];
}

-(void)setLabel:(NSString*)label andDesc:(NSString*)desc
{
    self.titleLabel.text = label;
    self.titleLabel.textColor = BLACK_COLOR;
    self.descriptionLabel.text = desc;
    self.descriptionLabel.textColor = GREY_COLOR;
}

@end
