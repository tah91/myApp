//
//  FavoritesViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 27/08/12.
//
//

#import <UIKit/UIKit.h>

@interface FavoritesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView* tableView;
@property (strong, nonatomic) NSMutableArray*       favorites;

@end
