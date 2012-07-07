//
//  MapResultViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 07/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapResultViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSMutableArray* results; 
@property (strong, nonatomic) NSString* searchPlace;

@end
