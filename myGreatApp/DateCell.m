//
//  DateCell.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 25/08/12.
//
//

#import "DateCell.h"

@implementation DateCell

@synthesize dateDisplay, delegate;

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

+ (NSDateFormatter*) getFormater
{
    static NSDateFormatter* dateFormatter = nil;
    if(dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterLongStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    }
    return dateFormatter;
}

- (void)setLabel:(NSString*)text initialValue:(NSDate*)initial isLast:(BOOL)isLast delegate:(id<InteractionLabelDelegate>)dropdownDelegate
{
    UIDatePicker* datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    
    if(initial != nil) {
        [datePicker setDate:initial];
    } else {
        //[datePicker setDate:initial];
    }
    
    self.dateDisplay.delegate = self;
    self.dateDisplay.text = [[DateCell getFormater] stringFromDate:datePicker.date];
    [self.dateDisplay setInputAccessoryView];
    self.dateDisplay.inputView = datePicker;
    self.dateDisplay.userInteractionEnabled = TRUE;
    self.label.text = text;
    self.delegate = dropdownDelegate;
    self.shouldSubmit = FALSE;
}

- (void)doResignFirstResponder
{
    [self.dateDisplay resignFirstResponder];
}

- (void)doBecomeFirstResponder
{
    [self.dateDisplay becomeFirstResponder];
}

- (NSString*)getCurrentValue
{
    return self.dateDisplay.text;
}

#pragma mark - InteractionLabel Selection

-(void)interactionBegin
{
    [delegate interactionBegin:self];
}

-(void)selectionDone
{
    UIDatePicker* datePicker = (UIDatePicker*)self.dateDisplay.inputView;
    self.dateDisplay.text = [[DateCell getFormater] stringFromDate:datePicker.date];
    [delegate selectionDone];
}

@end
