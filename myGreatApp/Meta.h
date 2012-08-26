//
//  Meta.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 25/08/12.
//
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

@interface Meta : Jastor

@property (nonatomic) NSInteger statusCode;
@property (nonatomic, copy) NSString* message;

@end
