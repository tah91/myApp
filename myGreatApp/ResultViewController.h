//
//  ResultViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 09/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "SearchCriteria.h"

@protocol ApplySeachDelegate

-(void)cancel;
-(void)confirmWithCriteria:(SearchCriteria*)criteria;

@end

@interface ResultViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, ApplySeachDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *activityView;
@property (strong, nonatomic) IBOutlet UIView *toolsView;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (weak, nonatomic) IBOutlet UIButton *orderByBtn;
@property (weak, nonatomic) IBOutlet UIButton *criteriaBtn;
@property (weak, nonatomic) IBOutlet UIButton *radiusBtn;
- (IBAction)switchView:(id)sender;

- (void)reloadData:(NSMutableArray*) localisations;

@property (strong, nonatomic) NSMutableArray* results; 
@property (strong, nonatomic) SearchCriteria* criteria;


@end
