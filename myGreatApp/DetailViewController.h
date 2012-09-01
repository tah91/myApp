//
//  DetailViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 30/07/12.
//
//

#import <UIKit/UIKit.h>
#import "Localisation.h"
#import "LoginViewController.h"

@interface DetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, LoginViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
- (IBAction)shareThis:(id)sender;
- (IBAction)addToFavorites:(id)sender;

@property (nonatomic) NSInteger locId;
@property (strong, nonatomic) Localisation* localisation;

@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;

@end
