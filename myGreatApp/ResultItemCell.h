//
//  ResultItemCell.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultItemCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *cityLabel;

@property (nonatomic) int locId;

@end
