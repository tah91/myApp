//
//  UINavigationController+TIAdditions.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 14/08/12.
//
//

#import <Foundation/Foundation.h>

@interface UIViewController (TIAdditions)

-(BOOL)isModal;

@end

@interface UINavigationController (TIAdditions)

-(void)cleanNavigationStackAndKeep:(Class)aClass;

@end
