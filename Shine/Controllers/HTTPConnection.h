//
//  HTTPConnection.h
//  Shine
//
//  Created by Ryan Gomba on 2/21/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

@class HTTPConnection;

@protocol HTTPConnectionDelegate
- (void)connection:(HTTPConnection *)connection requestDidSucceed:(NSDictionary *)response userInfo:(id)userInfo;
- (void)connection:(HTTPConnection *)connection requestDidFail:(NSError *)error userInfo:(id)userInfo;
@end

@interface HTTPConnection : NSObject <NSURLConnectionDataDelegate> {
    id userInfo;
    NSURLConnection *connection;
    NSMutableData *receivedData;
}

@property (weak, nonatomic) id <HTTPConnectionDelegate> delegate;

- (void)startWithURL:(NSURL *)url userInfo:(id)info;
- (void)startWithRequest:(NSURLRequest *)request userInfo:(id)info;
- (void)cancel;

@end
