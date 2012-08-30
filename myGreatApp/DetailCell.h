//
//  DetailCell.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 15/08/12.
//
//

#import <UIKit/UIKit.h>

#define kDetailCellIdent @"DetailCell"

@interface DetailCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel* titleLabel;
@property (nonatomic, strong) IBOutlet UILabel* descriptionLabel;

@property (nonatomic, weak) UIViewController* segueController;
@property (nonatomic, strong) NSString* segueIdent;

-(void)setLabel:(NSString*)label withSegue:(NSString*)segue andController:(UIViewController*)controller;
-(void)setLabelWithoutAccessory:(NSString*)label withSegue:(NSString*)segue andController:(UIViewController*)controller;

@end
