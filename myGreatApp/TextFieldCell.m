//
//  TextFieldCell.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 18/08/12.
//
//

#import "TextFieldCell.h"

@implementation TextFieldCell

@synthesize label,field,textFieldType, shouldSubmit;

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

- (void)setFieldType
{
    switch (self.textFieldType) {
        case TextfieldTypeStandard:
            self.field.keyboardType = UIKeyboardTypeDefault;
            self.field.autocapitalizationType = UITextAutocapitalizationTypeWords;
            break;
        case TextfieldTypeEmail:
            self.field.keyboardType = UIKeyboardTypeEmailAddress;
            break;
        case TextfieldTypeNumber:
            self.field.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case TextfieldTypePassword:
            self.field.keyboardType = UIKeyboardTypeDefault;
            self.field.secureTextEntry = TRUE;
            break;
        default:
            break;
    }
}
- (void)setLabel:(NSString*)text placeHolder:(NSString*)placeHolder initialValue:(NSString*)initial fieldType:(TextfieldType)theFieldType isLast:(BOOL)isLast delegate:(id <UITextFieldDelegate>)delegate
{    
    self.textFieldType = theFieldType;
    [self setFieldType];
    self.field.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.field.enablesReturnKeyAutomatically = TRUE;
    self.field.returnKeyType = isLast ? UIReturnKeyDone : UIReturnKeyNext;
    self.shouldSubmit = isLast;
    self.field.delegate = delegate;
    self.field.text = initial;
    self.field.placeholder = placeHolder;
    self.label.text = text;
}

- (void)doResignFirstResponder
{
    [self.field resignFirstResponder];
}

- (void)doBecomeFirstResponder
{
    if([self.field isFirstResponder])
        return;
    
    [self.field becomeFirstResponder];
}

- (NSString*)getCurrentValue
{
    return self.field.text;
}

@end
