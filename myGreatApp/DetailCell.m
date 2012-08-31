//
//  DetailCell.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 15/08/12.
//
//

#import "DetailCell.h"
#import "UIView+TIAdditions.h"

@implementation DetailCell

@synthesize titleLabel, descriptionLabel, segueIdent, segueController;

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
    UIColor * newShadow = selected ? BLACK_COLOR : WHITE_COLOR;
    
    self.titleLabel.shadowColor = newShadow;
    
    CGSize imgSize = self.frame.size;
    if(selected) {
        [self setBackgroundColor:GROUPED_BNG_SEL(imgSize)];
        [[self titleLabel] setTextColor:WHITE_COLOR];
        if(self.accessoryView != nil) {
            [self setAccessoryView:[[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"accessory-sel.png" ]]];
        }
    } else {
        [self setBackgroundColor:GROUPED_BNG(imgSize)];
        [[self titleLabel] setTextColor:GREY_COLOR];
        if(self.accessoryView != nil) {
            [self setAccessoryView:[[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"accessory.png" ]]];
        }
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animate
{
    [self setSelectedState:highlighted];
    [super setHighlighted:highlighted animated:animate];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [self setSelectedState:selected];
    [super setSelected:selected animated:animated];
    
    if(selected && [self.segueIdent length] != 0 && self.segueController != nil) {
        [self.segueController performSegueWithIdentifier:self.segueIdent sender:self.segueController];
    }
}

-(void)setLabel:(NSString*)label withSegue:(NSString*)segue andController:(UIViewController*)controller
{
    self.titleLabel.text = label;
    self.segueIdent = segue;
    self.segueController = controller;
    if([self.segueIdent length] != 0 && self.segueController != nil) {
        [self setAccessoryView:[[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"accessory.png" ]]];
    }
}

-(void)setLabelWithoutAccessory:(NSString*)label withSegue:(NSString*)segue andController:(UIViewController*)controller
{
    [self setLabel:label withSegue:segue andController:controller];
    [self setAccessoryView:nil];
}

@end
