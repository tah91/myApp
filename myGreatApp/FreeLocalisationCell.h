//
//  FreeLocalisationCell.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 27/07/12.
//
//

#import <UIKit/UIKit.h>
#import "LocalisationCell.h"

#define kFreeLocalisationCellIdent @"FreeLocalisationCell"

@interface FreeLocalisationCell : LocalisationCell

@property (nonatomic, strong) IBOutlet UIImageView* wifiLogo;
@property (nonatomic, strong) IBOutlet UIImageView* restoLogo;
@property (nonatomic, strong) IBOutlet UIImageView* coffeeLogo;
@property (nonatomic, strong) IBOutlet UIImageView* parkingLogo;
@property (nonatomic, strong) IBOutlet UIImageView* handicapLogo;

-(void)setFieldsFromLoc:(Localisation*)loc;

@end
