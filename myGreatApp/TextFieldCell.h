//
//  TextFieldCell.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 18/08/12.
//
//

#import <UIKit/UIKit.h>

typedef enum
{
    TextfieldTypeStandard,
    TextfieldTypeEmail,
    TextfieldTypePassword,
    TextfieldTypeNumber
} TextfieldType;

#define kTextFielCellIdent @"TextFieldCell"

@interface TextFieldCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel* label;
@property (nonatomic, strong) IBOutlet UITextField* field;
@property (nonatomic) TextfieldType textFieldType;
@property (nonatomic) BOOL shouldSubmit;

- (void)setLabel:(NSString*)label placeHolder:(NSString*)placeHolder initialValue:(NSString*)initial fieldType:(TextfieldType)fieldType isLast:(BOOL)isLast delegate:(id <UITextFieldDelegate>)delegate;
- (void)doResignFirstResponder;
- (void)doBecomeFirstResponder;
- (void)setFieldType;
- (NSString*)getCurrentValue;

@end
