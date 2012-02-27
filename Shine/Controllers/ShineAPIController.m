//
//  ShineAPIController.m
//  Shine
//
//  Created by Ryan Gomba on 2/24/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "ShineAPIController.h"

@implementation ShineAPIController

@synthesize delegate;

- (void)enableTemperatureBadgeWithLocation:(Location *)location
{
    NSLog(@"enabling badges");
    NSString *deviceToken = [ShineDefaults shared].deviceToken;
    if (deviceToken) {
        NSURL *url = [NSURL URLWithString:@"http://shine-server.herokuapp.com/badges"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:15];
        request.HTTPMethod = @"POST";
        NSDictionary *badge = [NSDictionary dictionaryWithObjectsAndKeys:
                               deviceToken, @"ua_id",
                               [NSString stringWithFormat:@"%@", location.latitude], @"latitude",
                               [NSString stringWithFormat:@"%@", location.longitude], @"longitude",
                               nil];
        NSDictionary *body = [NSDictionary dictionaryWithObject:badge forKey:@"badge"];
        request.HTTPBody = [body JSONData];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSLog(@"Sending the Shine request...");
        HTTPConnection *connection = [[HTTPConnection alloc] init];
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"enable_badge", @"type",
                                  location, @"location",
                                  nil];
        connection.delegate = self;
        [connection startWithRequest:request userInfo:userInfo];
    } else {
        NSLog(@"no token!");
        // error TODO
    }
}

- (void)disableTemperatureBadge
{
    NSLog(@"disabling badges");
    NSString *deviceToken = [ShineDefaults shared].deviceToken;
    if (deviceToken) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://shine-server.herokuapp.com/badges/%@", deviceToken]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:15];
        request.HTTPMethod = @"DELETE";
        NSLog(@"Sending the Shine request...");
        HTTPConnection *connection = [[HTTPConnection alloc] init];
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"disable_badge", @"type",
                                  nil];
        connection.delegate = self;
        [connection startWithRequest:request userInfo:userInfo];
    } else {
        NSLog(@"no token!");
    }
}

- (void)connection:(HTTPConnection *)connection requestDidSucceed:(NSDictionary *)response userInfo:(id)userInfo
{
    if ([[userInfo objectForKey:@"type"] isEqual:@"enable_badge"]) {
        NSLog(@"Did enable badge");
        Location *location = [userInfo objectForKey:@"location"];
        [ShineDefaults shared].badgedLocation = location.uid;
    } else {
        NSLog(@"Did disable badge");
        [ShineDefaults shared].badgedLocation = nil;
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    }
    [self.delegate shineAPIRequestDidSucceed];
}

- (void)connection:(HTTPConnection *)connection requestDidFail:(NSError *)error userInfo:(id)userInfo
{
    if ([[userInfo objectForKey:@"type"] isEqual:@"enable_badge"]) {
        NSLog(@"Did fail to enable badge");
        // TODO
    } else {
        NSLog(@"Did fail to disable badge");
        // TODO
    }
    [self.delegate shineAPIRequestDidFail];
}

@end
