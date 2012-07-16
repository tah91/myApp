//
//  FBRequestBlockDelegate.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 16/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FBRequestBlockDelegate.h"

@implementation FBRequestBlockDelegate

@synthesize requestDidFailWithErrorCallback, requestDidLoadCallback, requestLoadingCallback, requestDidLoadRawResponseCallback, requestDidReceiveResponseCallback;

- (id) initWithDidLoad:(RequestDidLoad)didload 
            andDidFail:(RequestDidFailWithError)didFail
{
    if (self = [super init])
    {
        requestDidLoadCallback = didload;
        requestDidFailWithErrorCallback = didFail;
    }
    return self;
}

- (void)requestLoading:(FBRequest*)request
{
    if (self.requestLoadingCallback) 
        self.requestLoadingCallback(request);
}

- (void)request:(FBRequest*)request didReceiveResponse:(NSURLResponse*)response
{
    if (self.requestDidReceiveResponseCallback) 
        self.requestDidReceiveResponseCallback(request, response);
}

- (void)request:(FBRequest*)request didFailWithError:(NSError*)error
{
    if (self.requestDidFailWithErrorCallback) 
        self.requestDidFailWithErrorCallback(request, error);
}

- (void)request:(FBRequest*)request didLoad:(id)result
{
    if (self.requestDidLoadCallback) 
        self.requestDidLoadCallback(request,result);
}

- (void)request:(FBRequest*)request didLoadRawResponse:(NSData*)data
{
    if (self.requestDidLoadRawResponseCallback) 
        self.requestDidLoadRawResponseCallback(request,data);
}

-(void)dealloc {
    self.requestDidFailWithErrorCallback = nil;
    self.requestDidLoadCallback = nil;
    self.requestDidLoadRawResponseCallback = nil;
    self.requestDidReceiveResponseCallback = nil;
    self.requestLoadingCallback = nil;
}

@end
