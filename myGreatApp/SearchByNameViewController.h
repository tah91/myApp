//
//  SearchByNameViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 28/08/12.
//
//

#import <UIKit/UIKit.h>

#define kSearchByNameKey  @"PreviousSearchByName"

@interface SearchByNameViewController : UIViewController <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray* previousSearch;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
