//
//  SelectTypeViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 28/07/12.
//
//

#import <UIKit/UIKit.h>
#import "ResultViewController.h"
#import "SearchCriteria.h"

@interface SelectTypeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UITableView *locTypesTableView;
@property (strong, nonatomic) IBOutlet UITableView *featuresTableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tabSelector;
- (IBAction)tabChanged:(id)sender;

@property (nonatomic, copy) NSDictionary* locTypes;
@property (nonatomic, copy) NSArray* locArray;
@property (nonatomic, copy) NSMutableSet* selectedLoc;
@property (nonatomic, copy) NSDictionary* featureTypes;
@property (nonatomic, copy) NSArray* featureArray;
@property (nonatomic, copy) NSMutableSet* selectedFeatures;
@property (strong,nonatomic) id <ApplySeachDelegate> applySearchDelegate;
@property (strong,nonatomic) SearchCriteria* criteria;

- (IBAction)cancel:(id)sender;
- (IBAction)confirm:(id)sender;

@end
