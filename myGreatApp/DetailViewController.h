//
//  DetailViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 30/07/12.
//
//

#import <UIKit/UIKit.h>
#import "Localisation.h"

@interface DetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

@property NSInteger locId;
@property (strong, nonatomic) Localisation* localisation;

@end
