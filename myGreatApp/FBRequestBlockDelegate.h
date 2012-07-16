//
//  FBRequestBlockDelegate.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 16/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBConnect.h"

typedef void(^RequestLoading)(FBRequest*);
typedef void(^RequestDidReceiveResponse)(FBRequest*,NSURLResponse*);
typedef void(^RequestDidFailWithError)(FBRequest*,NSError*);
typedef void(^RequestDidLoad)(FBRequest*,id);
typedef void(^RequestDidLoadRawResponse)(FBRequest*,NSData*);

@interface FBRequestBlockDelegate : NSObject <FBRequestDelegate>

- (id) initWithDidLoad:(RequestDidLoad)didload 
            andDidFail:(RequestDidFailWithError)didFail;

@property (nonatomic, copy) RequestLoading requestLoadingCallback;
@property (nonatomic, copy) RequestDidReceiveResponse requestDidReceiveResponseCallback;
@property (nonatomic, copy) RequestDidFailWithError requestDidFailWithErrorCallback;
@property (nonatomic, copy) RequestDidLoad requestDidLoadCallback;
@property (nonatomic, copy) RequestDidLoadRawResponse requestDidLoadRawResponseCallback;

@end
