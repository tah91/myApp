//
//  ReviewsViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 14/08/12.
//
//

#import <UIKit/UIKit.h>
#import "Localisation.h"
#import "AddCommentViewController.h"
#import "LoginViewController.h"

@interface CommentsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, AddCommentDelegate, LoginViewControllerDelegate>

- (IBAction)addComment:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addCommentBtn;

@property (strong, nonatomic) Localisation* localisation;

@end
