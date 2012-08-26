//
//  EditPasswordViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 22/08/12.
//
//

#import <UIKit/UIKit.h>
#import "FormViewController.h"

@interface EditPasswordViewController : FormViewController <UITableViewDelegate, UITableViewDataSource>

- (IBAction)editPasswordDone:(id)sender;

@end
