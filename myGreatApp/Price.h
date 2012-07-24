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

@property (nonatomic, copy) NSString*  desktop;
@property (nonatomic, copy) NSString*  workStation;
@property (nonatomic, copy) NSString*  meetingRoom;
@property (nonatomic, copy) NSString*  buisnessLounge;
@property (nonatomic, copy) NSString*  seminarRoom;
@property (nonatomic, copy) NSString*  visioRoom;

@end
