//
//  Image.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 26/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

@interface Image : Jastor

@property (nonatomic,copy) NSString* url;
@property (nonatomic,copy) NSString* thumbnail_url;

@end
