//
//  NSDate+TIAdditions.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 14/08/12.
//
//

#import "NSDate+TIAdditions.h"

@implementation NSDate (TIAdditions)

-(NSString *)dateDifferenceStringFromNow
{
    NSDate *now = [NSDate date];
    NSTimeInterval time = [self timeIntervalSinceDate:now];
    time *= -1;
    if (time < 60) {
        return @"il y a moins d'une minute";
    } else if (time < 3600) {
        int diff = round(time / 60);
        if (diff == 1)
            return @"il y a une minute";
        return [NSString stringWithFormat:@"il y a %d minutes", diff];
    } else if (time < 86400) {
        int diff = round(time / 60 / 60);
        if (diff == 1)
            return @"il y a une heure";
        return [NSString stringWithFormat:@"il y a %d heures", diff];
    } else if (time < 2592000) {
        int diff = round(time / 60 / 60 / 24);
        if (diff == 1)
            return @"hier";
        return[NSString stringWithFormat:@"il y a %d jours", diff];
    } else if (time < 31104000) {
        int diff = round(time / 60 / 60 / 24 / 30);
        return[NSString stringWithFormat:@"il y a %d mois", diff];
    } else {
        int diff = round(time / 60 / 60 / 24 / 30 / 12);
        if (diff == 1)
            return @"il y a un an";
        return[NSString stringWithFormat:@"il y a %d ans", diff];
    }
}

/*
 * This will convert DateTime (.NET) object serialized as JSON by WCF to a NSDate object.
 */
+(NSDate*) dateFromJson:(NSString*)json
{
    // Input string is something like: "/Date(1292851800000+0100)/" where
    // 1292851800000 is milliseconds since 1970 and +0100 is the timezone

    // This will tell number of seconds to add according to your default timezone
    // Note: if you don't care about timezone changes, just delete/comment it out
    NSInteger offset = [[NSTimeZone defaultTimeZone] secondsFromGMT];

    // A range of NSMakeRange(6, 10) will generate "1292851800" from "/Date(1292851800000+0100)/"
    // as in example above. We crop additional three zeros, because "dateWithTimeIntervalSince1970:"
    // wants seconds, not milliseconds; since 1 second is equal to 1000 milliseconds, this will work.
    // Note: if you don't care about timezone changes, just chop out "dateByAddingTimeInterval:offset" part
    NSDate* dateWithoutOffset = [NSDate dateWithTimeIntervalSince1970:[[json substringWithRange:NSMakeRange(6, 10)] intValue]];
    NSDate* date = [dateWithoutOffset dateByAddingTimeInterval:offset];
    
    return date;

    // You can just stop here if all you care is a NSDate object from inputString,
    // or see below on how to get a nice string representation from that date:

    // static is nice if you will use same formatter again and again (for example in table cells)
    /*static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        
        // If you're okay with the default NSDateFormatterShortStyle then comment out two lines below
        // or if you want four digit year, then this will do it:
        NSString *fourDigitYearFormat = [[dateFormatter dateFormat]
                                         stringByReplacingOccurrencesOfString:@"yy"
                                         withString:@"yyyy"];
        [dateFormatter setDateFormat:fourDigitYearFormat];
    }

    // There you have it:
    NSString *outputString = [dateFormatter stringFromDate:date];*/
}

@end
