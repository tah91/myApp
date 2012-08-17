//
//  UINavigationController+TIAdditions.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 14/08/12.
//
//

#import "UINavigationController+TIAdditions.h"

@implementation UINavigationController (TIAdditions)

-(void)cleanNavigationStackAndKeep:(Class)aClass
{
    NSMutableArray *allControllers = [[NSMutableArray alloc] initWithArray:self.viewControllers];
    NSArray *allControllersCopy = [allControllers copy];
    
    for (id object in allControllersCopy) {
        if (![object isKindOfClass:aClass])
            [allControllers removeObject:object];
    }
    [self setViewControllers:allControllers animated:NO];
}

@end
