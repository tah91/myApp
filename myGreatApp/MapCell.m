//
//  MapCell.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 01/09/12.
//
//

#import "MapCell.h"
#import "LocalisationAnnotation.h"

@implementation MapCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setPositionFromLat:(NSNumber*)lat lng:(NSNumber*)lng
{
    CLLocationCoordinate2D center;
    center.latitude = lat.doubleValue;
    center.longitude = lng.doubleValue;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(center, 200, 200);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    [self.mapView setRegion:adjustedRegion animated:YES];
    NSArray* annotations = [self.mapView annotations];
    [self.mapView removeAnnotations:annotations];
    LocalisationAnnotation* toAdd = [[LocalisationAnnotation alloc] initWithCoordinate:center];
    [self.mapView addAnnotation:toAdd];
}

@end
