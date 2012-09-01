//
//  DescriptionCell.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 01/09/12.
//
//

#import "DetailCell.h"

#define kDescriptionCellIdent @"DescriptionCell"

@interface DescriptionCell : DetailCell

@property (nonatomic, strong) IBOutlet UILabel* descriptionLabel;

-(void)setLabel:(NSString*)label andDesc:(NSString*)desc;

@end
