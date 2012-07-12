//
//  SearchViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray* previousSeach;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
