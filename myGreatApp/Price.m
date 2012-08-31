//
//  Price.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 23/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Price.h"

@implementation Price

@synthesize price,frequency;

-(NSString*)getDisplay {
    if([price length] == 0 || [frequency length] == 0) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@ / %@",price,frequency];
}

@end
