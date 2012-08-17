//
//  CommentCell.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 14/08/12.
//
//

#import <UIKit/UIKit.h>
#import "Comment.h"

#define POST_FONT_SIZE      12.0f
#define POST_CONTENT_WIDTH 210.0f
#define POST_CELL_HEIGHT    90.0f
#define POST_CONTENT_HEIGHT 21.0f

@interface CommentCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel*     nameLabel;
@property (nonatomic, strong) IBOutlet UILabel*     dateLabel;
@property (nonatomic, strong) IBOutlet UILabel*     postLabel;
@property (nonatomic, strong) IBOutlet UIImageView* memberPic;
@property (nonatomic, strong) IBOutlet UIImageView* ratingPic;
@property (nonatomic, strong) IBOutlet UIView*      bngView;

-(void)setFieldsFromCom:(Comment*)comment;
+(CGFloat)computeHeightFromPost:(NSString*)post;

@end
