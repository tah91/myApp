//
//  Comment.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 23/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"
#import "Member.h"

@interface Comment : Jastor

@property (nonatomic) NSInteger     id;
@property (nonatomic,copy) NSDate*  date;
@property (nonatomic,retain) Member*  author;
@property (nonatomic,copy) NSString* post;
@property (nonatomic) NSInteger     rating;
@property (nonatomic) NSInteger     ratingPrice;
@property (nonatomic) NSInteger     ratingWifi;
@property (nonatomic) NSInteger     ratingDispo;
@property (nonatomic) NSInteger     ratingWelcome;

@end
