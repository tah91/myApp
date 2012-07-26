//
//  ControllerHelper.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 19/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ALERT(X)	{UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:X delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];[alert show];}
#define ALERT_TITLE(X,Y)	{UIAlertView *alert = [[UIAlertView alloc] initWithTitle:X message:Y delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];[alert show];}

@interface ControllerHelper : NSObject

+(void)removeFromStackNavigation:(UINavigationController*) controller 
                          aclass:(Class)aClass;

+(void)hideEmptySeparators:(UITableViewController*) controller;

+(void)hideEmptyTableSeparators:(UITableView*) view;

@end
