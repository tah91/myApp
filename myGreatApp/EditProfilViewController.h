//
//  EditProfilViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 22/08/12.
//
//

#import <UIKit/UIKit.h>
#import "FormViewController.h"

@interface EditProfilViewController : FormViewController <UITableViewDelegate, UITableViewDataSource>

- (IBAction)editProfileDone:(id)sender;

@end
