//
//  ResultItemCell.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalisationCell.h"

@interface PayingLocalisationCell : LocalisationCell


@property (nonatomic, strong) IBOutlet UIImageView* desktopPic;
@property (nonatomic, strong) IBOutlet UILabel* desktopLabel;
@property (nonatomic, strong) IBOutlet UILabel* desktopPriceLabel;
@property (nonatomic, strong) IBOutlet UIImageView* meetingPic;
@property (nonatomic, strong) IBOutlet UILabel* meetingLabel;
@property (nonatomic, strong) IBOutlet UILabel* meetingPriceLabel;

-(void)setFieldsFromLoc:(Localisation*)loc;

@end
