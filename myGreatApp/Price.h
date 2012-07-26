//
//  Price.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 23/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

@interface Price : Jastor

@property (nonatomic) NSInteger  offerType;
@property (nonatomic, copy) NSString*  price;

@end
