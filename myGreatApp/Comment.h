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

@property (nonatomic)        NSInteger  id;
@property (nonatomic,copy)   NSString*  date;
@property (nonatomic,retain) Member*    author;
@property (nonatomic,copy)   NSString*  post;
@property (nonatomic,copy)   NSNumber*  ratingAverage;
@property (nonatomic,copy)   NSNumber*  rating;
@property (nonatomic,copy)   NSNumber*  ratingPrice;
@property (nonatomic,copy)   NSNumber*  ratingWifi;
@property (nonatomic,copy)   NSNumber*  ratingDispo;
@property (nonatomic,copy)   NSNumber*  ratingWelcome;

@end
