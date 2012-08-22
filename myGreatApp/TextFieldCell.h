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
    TextfieldTypePassword
} TextfieldType;

@interface TextFieldCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel* label;
@property (nonatomic, strong) IBOutlet UITextField* field;

- (void)setLabel:(NSString*)label initialValue:(NSString*)initial fieldType:(TextfieldType)fieldType isLast:(BOOL)isLast delegate:(id <UITextFieldDelegate>)delegate;
- (void)doResignFirstResponder;
- (void)doBecomeFirstResponder;

@end
