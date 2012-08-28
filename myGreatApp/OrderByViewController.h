//
//  OrderByViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 28/07/12.
//
//

#import <UIKit/UIKit.h>
#import "ResultViewController.h"
#import "SearchCriteria.h"

@interface OrderByViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView* tableView;
@property (weak, nonatomic) IBOutlet UINavigationBar *bar;

@property (nonatomic, copy) NSDictionary* orderByTypes;
@property (nonatomic, copy) NSArray* orderByArray;
@property (nonatomic, copy) NSIndexPath* checkedIndexPath;
@property (strong,nonatomic) id <ApplySeachDelegate> applySearchDelegate;
@property (strong,nonatomic) SearchCriteria* criteria;

- (IBAction)cancel:(id)sender;
- (IBAction)confirm:(id)sender;

@end
