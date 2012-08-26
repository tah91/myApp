//
//  FormViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 18/08/12.
//
//

#import <UIKit/UIKit.h>
#import "TextFieldCell.h"
#import "DropdownCell.h"
#import "TextViewCell.h"

@interface FormViewController : UIViewController <UITextFieldDelegate, InteractionLabelDelegate, UITextViewDelegate, TextViewEdition>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) TextFieldCell* currentCell;
@property (strong, nonatomic) NSMutableDictionary* currentValues;

-(void)submitForm;
-(void)initCurrentValues;
-(void)setCurrentValue:(NSString*)value forPath:(NSIndexPath*)indexPath;
-(NSString*)getCurrentValueForPath:(NSIndexPath*)indexPath;

@end
