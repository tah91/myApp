//
//  TextFieldCell.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 18/08/12.
//
//

#import "TextFieldCell.h"

@implementation TextFieldCell

@synthesize label,field;

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

- (void)setLabel:(NSString*)text initialValue:(NSString*)initial fieldType:(TextfieldType)theFieldType isLast:(BOOL)isLast delegate:(id <UITextFieldDelegate>)delegate
{  
    switch (theFieldType) {
        case TextfieldTypeStandard:
            self.field.autocapitalizationType = UITextAutocapitalizationTypeWords;
            break;
        case TextfieldTypeEmail:
            self.field.keyboardType = UIKeyboardTypeEmailAddress;
            break;
        case TextfieldTypePassword:
            self.field.secureTextEntry = TRUE;
        default:
            break;
    }
    self.field.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.field.enablesReturnKeyAutomatically = TRUE;
    self.field.returnKeyType = isLast ? UIReturnKeyDone : UIReturnKeyNext;
    self.field.delegate = delegate;
    self.field.text = initial;
    self.label.text = text;
}

- (void)doResignFirstResponder
{
    [self.field resignFirstResponder];
}

- (void)doBecomeFirstResponder
{
    [self.field becomeFirstResponder];
}

@end
