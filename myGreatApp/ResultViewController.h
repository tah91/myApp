//
//  ResultViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UITableViewController
{
    NSMutableArray* results; 
}

@property (strong, nonatomic) NSString* searchPlace;


@end
