//
//  FreeLocalisationCell.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 27/07/12.
//
//

#import <UIKit/UIKit.h>
#import "Localisation.h"

@interface FreeLocalisationCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel* nameLabel;
@property (nonatomic, strong) IBOutlet UILabel* distanceLabel;
@property (nonatomic, strong) IBOutlet UILabel* typeLabel;
@property (nonatomic, strong) IBOutlet UILabel* cityLabel;
@property (nonatomic, strong) IBOutlet UILabel* featureLabel;
@property (nonatomic, strong) IBOutlet UIImageView* mainPic;

@property (nonatomic) int locId;

-(void)setFieldsFromLoc:(Localisation*)loc;

@end
