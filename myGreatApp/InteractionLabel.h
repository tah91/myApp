//
//  InteractionLabel.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 25/08/12.
//
//

#import <UIKit/UIKit.h>
#import "TextFieldCell.h"

@protocol InteractionLabelDelegate

-(void)interactionBegin:(TextFieldCell*)cell;
-(void)selectionDone;

@end

@protocol InteractionLabelSelection

-(void)interactionBegin;
-(void)selectionDone;

@end

@interface InteractionLabel : UILabel

@property (nonatomic, retain) UIView *inputView;
@property (nonatomic, retain) UIView *inputAccessoryView;

-(void) setInputAccessoryView;
-(void) selectionDone;

@property (nonatomic,strong) id<InteractionLabelSelection> delegate;

@end