//
//  MinPrice.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 02/08/12.
//
//

#import <Foundation/Foundation.h>
#import "Jastor.h"
#import "Price.h"

@interface MinPrice : Jastor

@property (nonatomic) NSInteger  offerType;
@property (nonatomic, retain) Price*  price;

@end
