//
//  SearchButtonView.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 28/08/12.
//
//

#import <UIKit/UIKit.h>

#define kSearchButtonNib @"SearchButtonView"

@interface SearchButtonView : UIView

@property (nonatomic, strong) IBOutlet UILabel* title;
@property (nonatomic, strong) IBOutlet UILabel* subtitle;
@property (nonatomic, strong) IBOutlet UIImageView* imageView;

- (void)setTitle:(NSString *)aTitle withSubtitle:(NSString*)aSubtitle;

+(void)setBtn:(UIButton*)button owner:(id)owner title:(NSString *)aTitle withSubtitle:(NSString*)aSubtitle;
+(void)setBtnState:(UIButton*)button state:(BOOL)selected image:(UIImage*)anImage selectedImage:(UIImage*)aSelectedImage;

@end
