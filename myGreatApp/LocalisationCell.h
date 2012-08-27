//
//  LocalisationCell.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 07/08/12.
//
//

#import <UIKit/UIKit.h>
#import "Localisation.h"

@interface LocalisationCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel* nameLabel;
@property (nonatomic, strong) IBOutlet UILabel* typeLabel;
@property (nonatomic, strong) IBOutlet UIImageView* distancePic;
@property (nonatomic, strong) IBOutlet UILabel* distanceLabel;
@property (nonatomic, strong) IBOutlet UIImageView* cityPic;
@property (nonatomic, strong) IBOutlet UILabel* cityLabel;
@property (nonatomic, strong) IBOutlet UIImageView* ratingPic;
@property (nonatomic, strong) IBOutlet UIImageView* mainPic;

@property (strong, nonatomic) Localisation* localisation;

-(void)setSelectedState:(BOOL)selected;
-(void)setLabel:(UILabel*)label withText:(NSString*)text andColor:(UIColor*)color;
-(void)setFieldsFromLoc:(Localisation*)loc withSegue:(NSString*)segue andController:(UIViewController*)controller;

@property (nonatomic, weak) UIViewController* segueController;
@property (nonatomic, strong) NSString* segueIdent;

@end
