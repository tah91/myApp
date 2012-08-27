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

@interface CommentsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, AddCommentDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) Localisation* localisation;

@end
