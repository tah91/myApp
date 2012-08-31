//
//  LocalisationAnnotation.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 07/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Localisation.h"

@interface LocalisationAnnotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) NSInteger locId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (strong, nonatomic) Localisation* localisation;

- (id)initWithId:(NSInteger)theId name:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate localisation:(Localisation*)theLoc;

@end
