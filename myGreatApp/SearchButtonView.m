//
//  SearchButtonView.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 28/08/12.
//
//

#import "SearchButtonView.h"

@implementation SearchButtonView

@synthesize title, subtitle, imageView;

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

- (void)setTitle:(NSString *)aTitle withSubtitle:(NSString*)aSubtitle
{
    self.title.text = aTitle;
    self.subtitle.text = aSubtitle;
    self.userInteractionEnabled = NO;
    self.exclusiveTouch = NO;
}

+(void)setBtn:(UIButton*)button owner:(id)owner title:(NSString *)aTitle withSubtitle:(NSString*)aSubtitle
{
    NSArray *xib = [[NSBundle mainBundle] loadNibNamed:kSearchButtonNib owner:owner options:nil];
    SearchButtonView* btnView = [xib objectAtIndex:0];
    [btnView setTitle:aTitle withSubtitle:aSubtitle];
    
    [button addSubview:btnView];
    [button sendSubviewToBack:btnView];
    UIImage* bng = [[UIImage imageNamed:@"btn-blue.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
    UIImage* bngSel = [[UIImage imageNamed:@"btn-blue-sel.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
    [button setBackgroundImage:bng forState:UIControlStateNormal];
    [button setBackgroundImage:bngSel forState:UIControlStateSelected];
}

+(void)setBtnState:(UIButton*)button state:(BOOL)selected image:(UIImage*)anImage selectedImage:(UIImage*)aSelectedImage
{
    for (UIView* sub in [button subviews]) {
        if([sub isKindOfClass:[SearchButtonView class]]) {
            SearchButtonView* btnView = (SearchButtonView*)sub;
            btnView.title.textColor = selected ? WHITE_COLOR : BLUE_COLOR;
            btnView.subtitle.textColor = selected ? WHITE_COLOR : GREY_COLOR;
            btnView.imageView.image = selected ? aSelectedImage : anImage;
        }
    }
}

@end
