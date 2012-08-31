//
//  DropdownCell.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 22/08/12.
//
//

#import "DropdownCell.h"



@implementation DropdownCell

@synthesize delegate, dropdownValue, dropdownDict, dropdownKeys, dropdownValueDisplay;

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

- (void)setLabel:(NSString*)text initialValue:(NSString*)initial isLast:(BOOL)isLast source:(NSDictionary *)source delegate:(id<InteractionLabelDelegate>)dropdownDelegate
{
    UIPickerView* picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    picker.delegate = self;
    picker.dataSource = self;
    [picker setShowsSelectionIndicator:YES];
    
    self.dropdownDict = source;
    self.dropdownKeys = [[self.dropdownDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    self.dropdownValue = initial;
    self.dropdownValueDisplay.delegate = self;
    self.dropdownValueDisplay.text = (NSString*)[self.dropdownDict objectForKey:initial];
    self.dropdownValueDisplay.textColor = GREY_COLOR;
    [self.dropdownValueDisplay setInputAccessoryView];
    NSInteger index = [self.dropdownKeys indexOfObject:initial];
    [picker selectRow:index inComponent:0 animated:TRUE];
    self.dropdownValueDisplay.inputView = picker;
    self.dropdownValueDisplay.userInteractionEnabled = TRUE;
    self.label.text = text;
    self.label.textColor = BLUE_COLOR;
    self.delegate = dropdownDelegate;
    self.shouldSubmit = FALSE;
}

- (void)doResignFirstResponder
{
    [self.dropdownValueDisplay resignFirstResponder];
}

- (void)doBecomeFirstResponder
{
    [self.dropdownValueDisplay becomeFirstResponder];
}

- (NSString*)getCurrentValue
{
    return self.dropdownValue;
}

#pragma mark - InteractionLabel Selection

-(void)interactionBegin
{
    [delegate interactionBegin:self];
}

-(void)selectionDone
{
    [delegate selectionDone];
}

#pragma mark - UIPickerView Data Source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return dropdownDict.count;
}

#pragma mark - UIPickerView Delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSNumber* key = [self.dropdownKeys objectAtIndex:row];
    return (NSString*)[self.dropdownDict objectForKey:key];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.dropdownValue = [self.dropdownKeys objectAtIndex:row];
    self.dropdownValueDisplay.text = (NSString*)[self.dropdownDict objectForKey:self.dropdownValue];
}

@end
