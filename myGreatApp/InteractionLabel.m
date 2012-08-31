//
//  InteractionLabel.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 25/08/12.
//
//

#import "InteractionLabel.h"

@implementation InteractionLabel

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
@synthesize inputView, inputAccessoryView;

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate interactionBegin];
    [self becomeFirstResponder];
}

-(void) setInputAccessoryView
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem* done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                          target:self
                                                                          action:@selector(selectionDone)];
    
    UIBarButtonItem* flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:nil
                                                                                   action:nil];

    [toolbar setItems:[NSMutableArray arrayWithObjects:flexibleSpace,done, nil]];
    
    self.inputAccessoryView = toolbar;
}

-(void)selectionDone
{
    [self.delegate selectionDone];
}

@end
