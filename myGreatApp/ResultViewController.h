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

#define kResultPerPage 20

@protocol ApplySeachDelegate

-(void)cancel;
-(void)confirmWithCriteria:(SearchCriteria*)criteria;

@end

@interface ResultViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, ApplySeachDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIView *mapViewHelp;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *mapViewActivity;
@property (weak, nonatomic) IBOutlet UILabel *mapViewHelpLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *toolsView;
@property (weak, nonatomic) IBOutlet UIButton *orderByBtn;
@property (weak, nonatomic) IBOutlet UIButton *criteriaBtn;
@property (weak, nonatomic) IBOutlet UIButton *radiusBtn;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (weak, nonatomic) IBOutlet UIView *loadingView;
- (IBAction)switchView:(id)sender;

@property (strong, nonatomic) NSMutableArray*       results;
@property (strong, nonatomic) NSNumber*             maxCount;
@property (strong, nonatomic) NSMutableArray*       fetchedLocalisations;
@property (strong, nonatomic) SearchCriteria*       criteria;
@property (nonatomic)         BOOL                  isFetching;
@property (nonatomic)         BOOL                  fromCode;
@property (nonatomic)         CLLocationCoordinate2D center;
@property (nonatomic)         CLLocationCoordinate2D ne;
@property (nonatomic)         CLLocationCoordinate2D sw;

@end
