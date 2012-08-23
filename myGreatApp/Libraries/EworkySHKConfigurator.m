//
//  EworkySHKConfigurator.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 23/08/12.
//
//

#import "EworkySHKConfigurator.h"

@implementation EworkySHKConfigurator

/*
 App Description
 ---------------
 These values are used by any service that shows 'shared from XYZ'
 */
- (NSString*)appName {
	return @"eWorky for iPhone";
}

- (NSString*)appURL {
	return @"http://www.eworky.com";
}

// Facebook - https://developers.facebook.com/apps
// SHKFacebookAppID is the Application ID provided by Facebook
// SHKFacebookLocalAppID is used if you need to differentiate between several iOS apps running against a single Facebook app. Useful, if you have full and lite versions of the same app,
// and wish sharing from both will appear on facebook as sharing from one main app. You have to add different suffix to each version. Do not forget to fill both suffixes on facebook developer ("URL Scheme Suffix"). Leave it blank unless you are sure of what you are doing.
// The CFBundleURLSchemes in your App-Info.plist should be "fb" + the concatenation of these two IDs.
// Example:
//    SHKFacebookAppID = 555
//    SHKFacebookLocalAppID = lite
//
//    Your CFBundleURLSchemes entry: fb555lite
- (NSString*)facebookAppId {
	return @"339911822753190";
}

- (NSString*)facebookLocalAppId {
	return @"";
}

//Change if your app needs some special Facebook permissions only. In most cases you can leave it as it is.
- (NSArray*)facebookListOfPermissions {
    return [NSArray arrayWithObjects:@"publish_stream", @"offline_access", nil];
}

// ShareMenu Ordering
- (NSNumber*)shareMenuAlphabeticalOrder {
	return [NSNumber numberWithInt:1];// Setting this to 1 will show list in Alphabetical Order, setting to 0 will follow the order in SHKShares.plist
}

/* Name of the plist file that defines the class names of the sharers to use. Usually should not be changed, but this allows you to subclass a sharer and have the subclass be used. Also helps, if you want to exclude some sharers - you can create your own plist, and add it to your project. This way you do not need to change original SHKSharers.plist, which is a part of subproject - this allows you upgrade easily as you did not change ShareKit itself
 
 You can specify also your own bundle here, if needed. For example:
 return [[[NSBundle mainBundle] pathForResource:@"Vito" ofType:@"bundle"] stringByAppendingPathComponent:@"VKRSTestSharers.plist"]
 */
- (NSString*)sharersPlistName {
	return @"EworkySharers.plist";
}

// SHKActionSheet settings
- (NSNumber*)showActionSheetMoreButton {
	return [NSNumber numberWithBool:true];// Setting this to true will show More... button in SHKActionSheet, setting to false will leave the button out.
}

@end
