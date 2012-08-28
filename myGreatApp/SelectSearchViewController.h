//
//  SelectSearchViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchCriteria.h"

@interface SelectSearchViewController : UIViewController

@property (strong, nonatomic) SearchCriteria* criteria;
- (IBAction)selectFreeSpace:(id)sender;
- (IBAction)selectDesktop:(id)sender;
- (IBAction)selectMeetingRoom:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *freeSpaceButton;
@property (weak, nonatomic) IBOutlet UIButton *desktopButton;
@property (weak, nonatomic) IBOutlet UIButton *meetingRoomButton;
@property (weak, nonatomic) IBOutlet UIButton *launchSearchBtn;

@end
