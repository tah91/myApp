//
//  UIView+TIAdditions.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 14/08/12.
//
//

#import "UIView+TIAdditions.h"
#import "QuartzCore/CALayer.h"

@implementation UIView (TIAdditions)

-(void) removeAndHide
{
    [self removeFromSuperview];
    [self setFrame:CGRectZero];
}

@end

@implementation UIImageView (TIAdditions)

-(void) setImageWithStyle:(UIImage*)image;
{
    self.image = image;
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(2, 2);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 2.0;
    self.clipsToBounds = NO;
    [self.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [self.layer setBorderWidth: 2.0];
}

-(void) setRatingPic:(NSNumber*)rating
{
    if(rating >= [NSNumber numberWithInt:4]) {
        [self setImage:[UIImage imageNamed:@"rating-5.png"]];
        [self setHighlightedImage:[UIImage imageNamed:@"rating-5-sel.png"]];
    } else if(rating >= [NSNumber numberWithInt:3]) {
        [self setImage:[UIImage imageNamed:@"rating-4.png"]];
        [self setHighlightedImage:[UIImage imageNamed:@"rating-4-sel.png"]];
    } else if(rating >= [NSNumber numberWithInt:2]) {
        [self setImage:[UIImage imageNamed:@"rating-3.png"]];
        [self setHighlightedImage:[UIImage imageNamed:@"rating-3-sel.png"]];
    } else if(rating >= [NSNumber numberWithInt:1]) {
        [self setImage:[UIImage imageNamed:@"rating-2.png"]];
        [self setHighlightedImage:[UIImage imageNamed:@"rating-2-sel.png"]];
    } else if(rating >= [NSNumber numberWithInt:0]) {
        [self setImage:[UIImage imageNamed:@"rating-1.png"]];
        [self setHighlightedImage:[UIImage imageNamed:@"rating-1-sel.png"]];
    } else {
        [self setImage:[UIImage imageNamed:@"rating-0.png"]];
        [self setHighlightedImage:[UIImage imageNamed:@"rating-0-sel.png"]];
    }
}

@end

@implementation UIButton (TIAdditions)

-(void) setFBButtonWithStyle:(NSString*)title
{
    UIImage* bng = [UIImage imageNamed:@"btn-fb.png"];
    UIImage* bngSel = [UIImage imageNamed:@"btn-fb-sel.png"];
    [self setBackgroundImage:bng forState:UIControlStateNormal];
    [self setBackgroundImage:bngSel forState:UIControlStateHighlighted];
    [self setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    self.titleLabel.text = title;
    [[self titleLabel] setFont:FONT_BOLD(14.0f)];
}

-(void) setButtonWithStyle:(NSString*)title
{
    UIImage* bng = [[UIImage imageNamed:@"btn-blue.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
    UIImage* bngSel = [[UIImage imageNamed:@"btn-blue-sel.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
    [self setBackgroundImage:bng forState:UIControlStateNormal];
    [self setBackgroundImage:bngSel forState:UIControlStateHighlighted];
    [self setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    self.titleLabel.text = title;
    [[self titleLabel] setFont:FONT_BOLD(14.0f)];
}

@end

@implementation UILabel (TIAdditions)

-(void) setTitleWithStyle:(NSString*)title
{
    [self setTextColor:BLACK_COLOR];
    self.text = title;
    [self setFont:FONT_BOLD(14.0f)];
}

-(void) setSubtitleWithStyle:(NSString*)subtitle
{
    [self setTextColor:GREY_COLOR];
    self.text = subtitle;
    [self setFont:FONT_STD(12.0f)];
}

@end

@implementation UIImage (TIAdditions)

-(UIImage*)scaleToSize:(CGSize)size
{
    // Create a bitmap graphics context
    // This will also set it as the current context
    UIGraphicsBeginImageContext(size);
    
    // Draw the scaled image in the current context
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // Create a new image from current context
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // Pop the current context from the stack
    UIGraphicsEndImageContext();
    
    // Return our new scaled image
    return scaledImage;
}

@end

@implementation UIScrollView (TIAdditions)

-(void)setContentSizeFromSubviews
{
    CGFloat scrollViewHeight = 0.0f;
    for (UIView* view in self.subviews)
    {
        scrollViewHeight += view.frame.size.height;
    }
    [self setContentSize:(CGSizeMake(320, scrollViewHeight))];
}

@end