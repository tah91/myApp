//
//  SearchHomeViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 28/08/12.
//
//

#import <UIKit/UIKit.h>

@interface SearchHomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView* tableView;

@end
