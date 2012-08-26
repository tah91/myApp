//
//  UINavigationController+TIAdditions.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 14/08/12.
//
//

#import "UIViewController+TIAdditions.h"

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

@implementation UIViewController (TIAdditions)

-(BOOL)isModal
{
    
    BOOL isModal = ((self.parentViewController && self.parentViewController.modalViewController == self) ||
                    //or if I have a navigation controller, check if its parent modal view controller is self navigation controller
                    ( self.navigationController && self.navigationController.parentViewController && self.navigationController.parentViewController.modalViewController == self.navigationController) ||
                    //or if the parent of my UITabBarController is also a UITabBarController class, then there is no way to do that, except by using a modal presentation
                    [[[self tabBarController] parentViewController] isKindOfClass:[UITabBarController class]]);
    
    //iOS 5+
    if (!isModal && [self respondsToSelector:@selector(presentingViewController)]) {
        
        isModal = ((self.presentingViewController && self.presentingViewController.modalViewController == self) ||
                   //or if I have a navigation controller, check if its parent modal view controller is self navigation controller
                   (self.navigationController && self.navigationController.presentingViewController && self.navigationController.presentingViewController.modalViewController == self.navigationController) ||
                   //or if the parent of my UITabBarController is also a UITabBarController class, then there is no way to do that, except by using a modal presentation
                   [[[self tabBarController] presentingViewController] isKindOfClass:[UITabBarController class]]);
        
    }
    
    return isModal;        
    
}

@end
