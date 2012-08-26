//
//  TextViewCell.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 25/08/12.
//
//

#import "TextViewCell.h"

@implementation TextViewCell

@synthesize textView, editionDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)setLabel:(NSString*)label initialValue:(NSString*)initial isLast:(BOOL)isLast delegate:(id <UITextViewDelegate, TextViewEdition>)delegate;
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem* done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                          target:self
                                                                          action:@selector(selectionDone)];
    [toolbar setItems:[NSMutableArray arrayWithObjects:done, nil]];
    
    self.textView.inputAccessoryView = toolbar;
    self.textView.enablesReturnKeyAutomatically = TRUE;
    self.textView.returnKeyType = UIReturnKeyDefault;
    self.shouldSubmit = FALSE;
    self.textView.delegate = delegate;
    self.textView.text = initial;
    self.label.text = label;
}

- (void)doResignFirstResponder
{
    [self.textView resignFirstResponder];
}

- (void)doBecomeFirstResponder
{
    [self.textView becomeFirstResponder];
}

-(void)selectionDone
{
    [self.editionDelegate editionDone];
    [self doResignFirstResponder];
}
- (NSString*)getCurrentValue
{
    return self.textView.text;
}

@end
