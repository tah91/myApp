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

-(void) setImageWithStyle:(UIImage*)image;
-(void) setRatingPic:(NSNumber*)rating;

@end

@interface UIImage (TIAdditions)

-(UIImage*)scaleToSize:(CGSize)size;

@end
