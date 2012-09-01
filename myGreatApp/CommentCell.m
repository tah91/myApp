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
    
    [self.memberPic setImageWithStyle:comment.author.avatar.thumbnail_url emptyName:@"avatar.png"];
    [self.ratingPic setCommentRatingPic:comment.ratingAverage];

    CGFloat newHeight = [CommentCell computeHeightFromPost:comment.post];
    CGRect previous = [self.postLabel frame];
    [self.postLabel setFrame:CGRectMake(previous.origin.x, previous.origin.y, previous.size.width, newHeight)];

    
    previous = [self.bngView frame];
    [self.bngView setFrame:CGRectMake(previous.origin.x, previous.origin.y, previous.size.width, previous.size.height - POST_CONTENT_HEIGHT + newHeight)];
    UIImage* bng = [[UIImage imageNamed:@"comment-bng.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(24, 16, 25, 18)];
    UIImageView* background = [[UIImageView alloc] initWithImage:bng];
    background.frame = CGRectMake(0, 0, self.bngView.frame.size.width, self.bngView.frame.size.height);
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
