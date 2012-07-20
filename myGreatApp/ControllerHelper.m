//
//  ControllerHelper.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 19/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ControllerHelper.h"

@implementation ControllerHelper

+(void)removeFromStackNavigation:(UINavigationController*) controller 
                          aclass:(Class)aClass {
    NSMutableArray *allControllers = [[NSMutableArray alloc] initWithArray:controller.viewControllers];
    NSArray *allControllersCopy = [allControllers copy];
    
    for (id object in allControllersCopy) {
        if (![object isKindOfClass:aClass])
            [allControllers removeObject:object];
    }
    [controller setViewControllers:allControllers animated:NO]; 
}

@end
