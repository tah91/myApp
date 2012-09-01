//
//  LocalisationCell.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 07/08/12.
//
//

#import "LocalisationCell.h"
#import "UIView+TIAdditions.h"
#import "AppDelegate.h"

@implementation LocalisationCell

@synthesize nameLabel,distanceLabel,typeLabel,cityLabel,mainPic,distancePic,cityPic,ratingPic;
@synthesize localisation;
@synthesize segueController,segueIdent;
@synthesize imageLoadingOperation;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelectedState:(BOOL)selected
{
    UIColor * newShadow = selected ? GREY_COLOR : WHITE_COLOR;
    
    nameLabel.shadowColor = newShadow;
    typeLabel.shadowColor = newShadow;
    distanceLabel.shadowColor = newShadow;
    cityLabel.shadowColor = newShadow;
    
    if(selected) {
        [self setAccessoryView:[[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"accessory-sel.png" ]]];
    } else {
        [self setAccessoryView:[[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"accessory.png" ]]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [self setSelectedState:selected];
    
    if(selected && [self.segueIdent length] != 0 && self.segueController != nil) {
        [self.segueController performSegueWithIdentifier:self.segueIdent sender:self.segueController];
    }
    
    [super setSelected:selected animated:animated];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animate
{
    [self setSelectedState:highlighted];
    [super setHighlighted:highlighted animated:animate];
}

-(void)setLabel:(UILabel*)label withText:(NSString*)text andColor:(UIColor*)color
{
    [label setText:text];
    [label setTextColor:color];
}

-(void)setFieldsFromLoc:(Localisation*)loc withSegue:(NSString*)segue andController:(UIViewController*)controller
{
    [self setLabel:nameLabel
          withText:loc.name
          andColor:BLUE_COLOR];

    [self setLabel:typeLabel
          withText:[NSString stringWithFormat:@"%@ - %@", loc.type, loc.city]
          andColor:ORANGE_COLOR];
    
    [self setLabel:distanceLabel
          withText:[loc getDistance]
          andColor:GREY_COLOR];
    
    [self setLabel:cityLabel
          withText:loc.city
          andColor:GREY_COLOR];
    
    [self.mainPic setImageStyle];
    
    NSString* imageUrl = [loc getMainImage:true];
    if([imageUrl length] == 0) {
        self.mainPic.image = [UIImage imageNamed:@"place-empty.png"];
    } else {
        self.imageLoadingOperation = [ApplicationDelegate.localisationEngine imageAtURL:[NSURL URLWithString:imageUrl]
                                                                     onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                                         
                                                                         if([imageUrl isEqualToString:[url absoluteString]]) {
                                                                             
                                                                             if (isInCache) {
                                                                                 self.mainPic.image = fetchedImage;
                                                                             } else {
                                                                                 UIImageView *loadedImageView = [[UIImageView alloc] initWithImage:fetchedImage];
                                                                                 loadedImageView.frame = self.mainPic.frame;
                                                                                 loadedImageView.alpha = 0;
                                                                                 [self.contentView addSubview:loadedImageView];
                                                                                 
                                                                                 [UIView animateWithDuration:0.4
                                                                                                  animations:^
                                                                                  {
                                                                                      loadedImageView.alpha = 1;
                                                                                      self.mainPic.alpha = 0;
                                                                                  }
                                                                                                  completion:^(BOOL finished)
                                                                                  {
                                                                                      self.mainPic.image = fetchedImage;
                                                                                      self.mainPic.alpha = 1;
                                                                                      [loadedImageView removeFromSuperview];
                                                                                  }];
                                                                             }
                                                                         }
                                                                     }];
    }
    
    [self.ratingPic setRatingPic:loc.rating];
    
    [self setAccessoryView:[[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"accessory-sel.png" ]]];
    
    UIImage* bng = [[UIImage imageNamed:@"list-bng.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,0,0,0)];
    [self setBackgroundView:[[UIImageView alloc] initWithImage:bng]];
    UIImage* selBng = [[UIImage imageNamed:@"list-bng-sel.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,0,0,0)];
    [self setSelectedBackgroundView:[[UIImageView alloc] initWithImage:selBng]];
    
    self.localisation = loc;
    self.segueIdent = segue;
    self.segueController = controller;
}

@end
