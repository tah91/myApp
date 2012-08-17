//
//  NSDate+TIAdditions.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 14/08/12.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (TIAdditions)

-(NSString*) dateDifferenceStringFromNow;
+(NSDate*) dateFromJson:(NSString*)json;

@end
