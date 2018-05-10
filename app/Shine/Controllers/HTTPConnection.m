//
//  HTTPConnection.m
//  Shine
//
//  Created by Ryan Gomba on 2/21/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "HTTPConnection.h"
#import "JSONKit.h"

@implementation HTTPConnection

@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        receivedData = [NSMutableData data];
    }
    return self;
}

- (void)startWithRequest:(NSURLRequest *)request userInfo:(id)info
{
    userInfo = info;
    NSLog(@"Sending the request...");
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [connection start];
}

- (void)startWithURL:(NSURL *)url userInfo:(id)info
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:15];
    [self startWithRequest:request userInfo:info];
}

- (void)cancel
{
    [connection cancel];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
    [self.delegate connection:self requestDidFail:error userInfo:userInfo];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int responseStatusCode = [httpResponse statusCode];
    NSLog(@"RESPONSE: %d", responseStatusCode);
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"data");
    [receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"finished");
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    JSONDecoder *decoder = [JSONDecoder decoder];
    NSDictionary *content = [decoder objectWithData:receivedData];
    if (content) {
        NSLog(@"GOT IT");
        [self.delegate connection:self requestDidSucceed:content userInfo:userInfo];
    } else {
        NSLog(@"Error deconding JSON");
        NSError *error = [NSError errorWithDomain:@"Error deconding JSON" code:600 userInfo:nil];
        [self.delegate connection:self requestDidFail:error userInfo:userInfo];
    }
}

@end
