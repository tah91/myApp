//
//  TextViewCell.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 25/08/12.
//
//

#import "TextFieldCell.h"

#define kTextViewCellIdent @"TextViewCell"

@class TextViewCell;

@protocol TextViewEdition

-(void)editionDone;

@end

@interface TextViewCell : TextFieldCell

@property (nonatomic, strong) IBOutlet UITextView* textView;

- (void)setLabel:(NSString*)label initialValue:(NSString*)initial isLast:(BOOL)isLast delegate:(id <UITextViewDelegate>)delegate;
- (void)doResignFirstResponder;
- (void)doBecomeFirstResponder;
- (void)selectionDone;

@property (nonatomic,strong) id<TextViewEdition> editionDelegate;

@end
