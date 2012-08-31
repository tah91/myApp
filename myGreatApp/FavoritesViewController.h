//
//  FavoritesViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 27/08/12.
//
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface FavoritesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, LoginViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView* tableView;
@property (strong, nonatomic) NSMutableArray*       favorites;

- (void) shouldFetchData;

@end
