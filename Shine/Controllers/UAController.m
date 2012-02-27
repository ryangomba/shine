//
//  UAController.m
//  Shine
//
//  Created by Ryan Gomba on 2/23/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "UAController.h"
#import "NSData+Base64.h"

@implementation UAController

- (void)registerDevice:(NSString *)token
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://go.urbanairship.com/api/device_tokens/%@/", token]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:15];
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", @"jk1fEK12Tkm_QAuVqhWQZQ", @"TvnZ3HkXQ4y1BCoTme8SvA"];
    NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodingWithLineLength:80]];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    NSLog(@"Sending the UA request...");
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int responseStatusCode = [httpResponse statusCode];
    NSLog(@"UA RESPONSE: %d", responseStatusCode);
}

@end
