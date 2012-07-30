//
//  ResultItemCell.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Localisation.h"

@interface LocalisationCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel* nameLabel;
@property (nonatomic, strong) IBOutlet UILabel* distanceLabel;
@property (nonatomic, strong) IBOutlet UILabel* typeLabel;
@property (nonatomic, strong) IBOutlet UILabel* cityLabel;
@property (nonatomic, strong) IBOutlet UILabel* desktopPriceLabel;
@property (nonatomic, strong) IBOutlet UILabel* meetingPriceLabel;
@property (nonatomic, strong) IBOutlet UIImageView* mainPic;

@property (nonatomic) int locId;

-(void)setFieldsFromLoc:(Localisation*)loc;

@end
