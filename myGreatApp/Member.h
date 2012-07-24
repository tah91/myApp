//
//  Member.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 23/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

@interface Member : Jastor

@property (nonatomic) NSInteger id;
@property (nonatomic, copy) NSString* firstName;
@property (nonatomic, copy) NSString* lastName;
@property (nonatomic, copy) NSString* avatar;
@property (nonatomic, copy) NSString* companyName;
@property (nonatomic, copy) NSString* city;
@property (nonatomic, copy) NSString* profile;
@property (nonatomic, copy) NSString* description;
@property (nonatomic, copy) NSString* twitter;
@property (nonatomic, copy) NSString* facebook;
@property (nonatomic, copy) NSString* linkedin;
@property (nonatomic, copy) NSString* viadeo;

@end
