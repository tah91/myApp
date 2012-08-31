//
//  UIView+TIAdditions.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 14/08/12.
//
//

#import <Foundation/Foundation.h>

@interface UIView (TIAdditions)

-(void) removeAndHide;

@end

@interface UIImageView (TIAdditions)

-(void) setImageWithStyle:(NSString*)imageUrl emptyName:(NSString*)emptyName;
-(void) setRatingPic:(NSNumber*)rating;
-(void) setCommentRatingPic:(NSNumber*)rating;

@end

@interface UIImage (TIAdditions)

-(UIImage*)scaleToSize:(CGSize)size;

@end

@interface UIButton (TIAdditions)

-(void)setFBButtonWithStyle:(NSString*)title;
-(void)setButtonWithStyle:(NSString*)title;

@end

@interface UILabel (TIAdditions)

-(void) setTitleWithStyle:(NSString*)title;

-(void) setSubtitleWithStyle:(NSString*)subtitle;

@end

@interface UIScrollView (TIAdditions)

-(void)setContentSizeFromSubviews;

@end

@interface UINavigationBar (TIAdditions)

-(void) applyDefaultStyle;

@end