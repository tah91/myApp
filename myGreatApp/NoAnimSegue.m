//
//  NoAnimSegue.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 15/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NoAnimSegue.h"

@implementation NoAnimSegue

- (void)perform {
    [self.sourceViewController presentModalViewController:self.destinationViewController animated:NO];
}

@end
