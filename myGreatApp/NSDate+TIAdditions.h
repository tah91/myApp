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
-(NSString*) toCSharpDate;

@end

@interface NSMutableDictionary (TIAdditions)

-(void)trySetObject:(id)anObject forKey:(id)aKey;

@end