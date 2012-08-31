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

@interface SelectTypeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSMutableSet* _selectedLoc;
    NSMutableSet* _selectedFeatures;
}

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UINavigationBar *bar;
@property (strong, nonatomic) IBOutlet UITableView *locTypesTableView;
@property (strong, nonatomic) IBOutlet UITableView *featuresTableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tabSelector;
- (IBAction)tabChanged:(id)sender;

@property (nonatomic, copy) NSDictionary* locTypes;
@property (nonatomic, copy) NSArray* locArray;
@property (nonatomic, copy) NSDictionary* featureTypes;
@property (nonatomic, copy) NSArray* featureArray;
@property (strong,nonatomic) id <ApplySeachDelegate> applySearchDelegate;
@property (strong,nonatomic) SearchCriteria* criteria;

- (IBAction)cancel:(id)sender;
- (IBAction)confirm:(id)sender;

@end
