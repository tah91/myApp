//
//  SearchViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController
- (IBAction)doSearch:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *searchPlace;
- (IBAction)placeEntered:(id)sender;

@end
