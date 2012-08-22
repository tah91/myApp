//
//  DropdownCell.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 22/08/12.
//
//

#import "DropdownCell.h"

@implementation UIDropdownLabel

@synthesize inputView, inputAccessoryView;

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self becomeFirstResponder];
}

@end

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

- (void)setLabel:(NSString*)text initialValue:(NSNumber*)initial isLast:(BOOL)isLast source:(NSDictionary *)source delegate:(id<DropdownCellDelegate>)dropdownDelegate
{
    UIPickerView* picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    picker.delegate = self;
    picker.dataSource = self;
    [picker setShowsSelectionIndicator:YES];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem* done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                          target:self
                                                                          action:@selector(selectionDone:)];
    [toolbar setItems:[NSMutableArray arrayWithObjects:done, nil]];
    
    self.dropdownDict = source;
    self.dropdownKeys = [[self.dropdownDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    self.dropdownValue = initial;
    self.dropdownValueDisplay.text = (NSString*)[self.dropdownDict objectForKey:initial];
    self.dropdownValueDisplay.inputAccessoryView = toolbar;
    NSInteger index = [self.dropdownKeys indexOfObject:initial];
    [picker selectRow:index inComponent:0 animated:TRUE];
    self.dropdownValueDisplay.inputView = picker;
    self.dropdownValueDisplay.userInteractionEnabled = TRUE;
    self.label.text = text;
    self.delegate = dropdownDelegate;
}

-(void)selectionDone:(id)sender
{
    [delegate selectionDone:self];
}

- (void)doResignFirstResponder
{
    [self.dropdownValueDisplay resignFirstResponder];
}

- (void)doBecomeFirstResponder
{
    [self.dropdownValueDisplay becomeFirstResponder];
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
