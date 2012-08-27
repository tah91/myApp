//
//  RatingCell.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 27/08/12.
//
//

#import "RatingCell.h"

@implementation RatingCell

@synthesize rating, ratingControl;

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

- (void)setLabel:(NSString*)label initialValue:(float)initial isLast:(BOOL)isLast delegate:(id <RatingDelegate>)delegate
{
    DLStarRatingControl* ratings = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(0, 0, self.ratingControl.bounds.size.width, self.ratingControl.bounds.size.height)
                                                                                 andStars:5
                                                                             isFractional:NO];
    ratings.delegate = self;
	ratings.backgroundColor = [UIColor clearColor];
	/*ratings.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;*/
	ratings.rating = initial;
    [self.ratingControl addSubview:ratings];
    
    self.rating = [NSNumber numberWithFloat:initial];
    self.shouldSubmit = FALSE;
    self.label.text = label;
    self.delegate = delegate;
}

- (void)doResignFirstResponder
{
    return;
}

- (void)doBecomeFirstResponder
{
    return;
}

- (NSString*)getCurrentValue
{
    return self.rating.stringValue;
}

#pragma mark DLStarRatingControl delegate

-(void)newRating:(DLStarRatingControl *)control :(float)theRating
{
	self.rating = [NSNumber numberWithFloat:theRating];
    [self.delegate ratingDone:self];
}

@end
