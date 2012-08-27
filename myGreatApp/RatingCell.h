//
//  RatingCell.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 27/08/12.
//
//

#import "TextFieldCell.h"
#import "DLStarRatingControl.h"

#define kRatingCellIdent @"RatingCell"

@protocol RatingDelegate

-(void)ratingDone:(TextFieldCell*)cell;

@end

@interface RatingCell : TextFieldCell <DLStarRatingDelegate>

- (void)setLabel:(NSString*)label initialValue:(float)initial isLast:(BOOL)isLast delegate:(id <RatingDelegate>)delegate;

@property (nonatomic,strong) NSNumber* rating;
@property (nonatomic,strong) id<RatingDelegate> delegate;
@property (nonatomic,strong) IBOutlet UIView* ratingControl;

@end
