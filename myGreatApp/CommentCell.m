//
//  CommentCell.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 14/08/12.
//
//

#import "CommentCell.h"
#import "NSDate+TIAdditions.h"
#import "UIView+TIAdditions.h"
#import "AppDelegate.h"

@implementation CommentCell

@synthesize nameLabel,postLabel,dateLabel,memberPic,ratingPic,bngView;

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

    // Configure the view for the selected state
}

-(void)setFieldsFromCom:(Comment*)comment
{
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", comment.author.firstName, comment.author.lastName];
    self.dateLabel.text = [[NSDate dateFromRFC1123:comment.date] dateDifferenceStringFromNow];
    self.dateLabel.textColor = ORANGE_COLOR;
    self.postLabel.text = comment.post;
    self.postLabel.textColor = GREY_COLOR;
    
    [self.memberPic setImageStyle];
    NSString* imageUrl = comment.author.avatar.thumbnail_url;
    if([imageUrl length] == 0) {
        self.memberPic.image = [UIImage imageNamed:@"avatar.png"];
    } else {
        self.imageLoadingOperation = [ApplicationDelegate.localisationEngine imageAtURL:[NSURL URLWithString:imageUrl]
                                                                           onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                                               
                                                                               if([imageUrl isEqualToString:[url absoluteString]]) {
                                                                                   
                                                                                   if (isInCache) {
                                                                                       self.memberPic.image = fetchedImage;
                                                                                   } else {
                                                                                       UIImageView *loadedImageView = [[UIImageView alloc] initWithImage:fetchedImage];
                                                                                       loadedImageView.frame = self.memberPic.frame;
                                                                                       loadedImageView.alpha = 0;
                                                                                       [self.contentView addSubview:loadedImageView];
                                                                                       
                                                                                       [UIView animateWithDuration:0.4
                                                                                                        animations:^
                                                                                        {
                                                                                            loadedImageView.alpha = 1;
                                                                                            self.memberPic.alpha = 0;
                                                                                        }
                                                                                                        completion:^(BOOL finished)
                                                                                        {
                                                                                            self.memberPic.image = fetchedImage;
                                                                                            self.memberPic.alpha = 1;
                                                                                            [loadedImageView removeFromSuperview];
                                                                                        }];
                                                                                   }
                                                                               }
                                                                           }];
    }
    
    [self.ratingPic setCommentRatingPic:comment.ratingAverage];

    CGFloat newHeight = [CommentCell computeHeightFromPost:comment.post];
    CGRect previous = [self.postLabel frame];
    [self.postLabel setFrame:CGRectMake(previous.origin.x, previous.origin.y, previous.size.width, newHeight)];

    previous = [self.bngView frame];
    [self.bngView setFrame:CGRectMake(previous.origin.x, previous.origin.y, previous.size.width, POST_CONTAINER_HEIGHT - POST_CONTENT_HEIGHT + newHeight)];
    
    UIImage* bng = [[UIImage imageNamed:@"comment-bng.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(24, 16, 25, 18)];
    UIImageView* background = [[UIImageView alloc] initWithImage:bng];
    background.frame = CGRectMake(0, 0, self.bngView.frame.size.width, self.bngView.frame.size.height);
    for (UIView* sub in self.bngView.subviews) {
        if([sub isKindOfClass:[UIImageView class]]) {
            [sub removeFromSuperview];
        }
    }
    [self.bngView addSubview:background];
    [self.bngView sendSubviewToBack:background];
}

+(CGFloat)computeHeightFromPost:(NSString*)post
{    
    CGSize constraint = CGSizeMake(POST_CONTENT_WIDTH, 20000.0f);
    CGSize size = [post sizeWithFont:FONT_STD(POST_FONT_SIZE)
                   constrainedToSize:constraint
                       lineBreakMode:UILineBreakModeWordWrap];
    //CGFloat height = MAX(size.height, POST_CONTENT_HEIGHT);
    
    return size.height;
}

@end
