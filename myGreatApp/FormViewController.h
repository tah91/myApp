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

@interface FormViewController : UIViewController <UITextFieldDelegate, DropdownCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

-(void)submitForm;

@end
