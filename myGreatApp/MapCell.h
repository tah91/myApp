//
//  MapCell.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 01/09/12.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapCell : UITableViewCell

@property (strong, nonatomic) IBOutlet MKMapView* mapView;

-(void)setPositionFromLat:(NSNumber*)lat lng:(NSNumber*)lng;

@end
