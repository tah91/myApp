//
//  SelectRadiusViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 28/07/12.
//
//

#import <UIKit/UIKit.h>
#import "ResultViewController.h"
#import "SearchCriteria.h"

@interface SelectRadiusViewController : UITableViewController

@property (nonatomic, copy) NSDictionary* radiusTypes;
@property (nonatomic, copy) NSArray* radiusArray;
@property (nonatomic, copy) NSIndexPath* checkedIndexPath;
@property (strong,nonatomic) id <ApplySeachDelegate> applySearchDelegate;
@property (strong,nonatomic) SearchCriteria* criteria;

- (IBAction)cancel:(id)sender;
- (IBAction)confirm:(id)sender;

@end
