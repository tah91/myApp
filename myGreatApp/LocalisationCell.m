//
//  LocalisationCell.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 07/08/12.
//
//

#import "LocalisationCell.h"
#import "QuartzCore/CALayer.h"

@implementation LocalisationCell

@synthesize nameLabel,distanceLabel,typeLabel,cityLabel,mainPic,distancePic,cityPic,ratingPic;
@synthesize locId;

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

-(void)setLabel:(UILabel*)label withText:(NSString*)text andColor:(UIColor*)color {
    [label setText:text];
    [label setTextColor:color];
    //[label setShadowColor:[UIColor whiteColor]];
    [label setShadowOffset:CGSizeMake(1,1)];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animate
{
    UIColor * newShadow = highlighted ? [UIColor blackColor] : [UIColor whiteColor];
    
    nameLabel.shadowColor = newShadow;
    typeLabel.shadowColor = newShadow;
    distanceLabel.shadowColor = newShadow;
    cityLabel.shadowColor = newShadow;
    
    [super setHighlighted:highlighted animated:animate];
}

-(void)setFieldsFromLoc:(Localisation*)loc {
    
    [self setLabel:nameLabel
          withText:loc.name
          andColor:[UIColor colorWithRed:0.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0]];

    [self setLabel:typeLabel
          withText:[NSString stringWithFormat:@"%@ - %@", loc.type, loc.city]
          andColor:[UIColor colorWithRed:247.0/255.0 green:148.0/255.0 blue:29.0/255.0 alpha:1.0]];
    
    [self setLabel:distanceLabel
          withText:[loc getDistance]
          andColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    
    [self setLabel:cityLabel
          withText:loc.city
          andColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    
    mainPic.image = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:[loc getMainImage:true]]]];
    mainPic.layer.shadowColor = [UIColor grayColor].CGColor;
    mainPic.layer.shadowOffset = CGSizeMake(2, 2);
    mainPic.layer.shadowOpacity = 1;
    mainPic.layer.shadowRadius = 2.0;
    mainPic.clipsToBounds = NO;
    [mainPic.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [mainPic.layer setBorderWidth: 2.0];
    
    if(loc.rating >= [NSNumber numberWithInt:4]) {
        [ratingPic setImage:[UIImage imageNamed:@"rating-5.png"]];
    } else if(loc.rating >= [NSNumber numberWithInt:3]) {
        [ratingPic setImage:[UIImage imageNamed:@"rating-4.png"]];
    } else if(loc.rating >= [NSNumber numberWithInt:2]) {
        [ratingPic setImage:[UIImage imageNamed:@"rating-3.png"]];
    } else if(loc.rating >= [NSNumber numberWithInt:1]) {
        [ratingPic setImage:[UIImage imageNamed:@"rating-2.png"]];
    } else if(loc.rating >= [NSNumber numberWithInt:0]) {
        [ratingPic setImage:[UIImage imageNamed:@"rating-1.png"]];
    } else {
        [ratingPic setImage:[UIImage imageNamed:@"rating-0.png"]];
    }
    
    UIImage* bng = [[UIImage imageNamed:@"list-bng.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,0,0,0)];
    [self setBackgroundView:[[UIImageView alloc] initWithImage:bng]];
    UIImage* selBng = [[UIImage imageNamed:@"list-bng-sel.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,0,0,0)];
    [self setSelectedBackgroundView:[[UIImageView alloc] initWithImage:selBng]];
    
    locId = loc.id;
}

@end
