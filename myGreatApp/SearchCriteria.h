//
//  SearchCriteria.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchCriteria : NSObject

@property (strong, nonatomic) NSString* place;
@property (nonatomic) BOOL freePlace;
@property (nonatomic) BOOL desktop;
@property (nonatomic) BOOL meetingRoom;

-(id) initWithPlace:(NSString*)place;

@end
