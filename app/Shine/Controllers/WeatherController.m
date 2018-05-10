//
//  WeatherController.m
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "WeatherController.h"

#import "CurrentReport.h"
#import "DailyReport.h"
#import "HourlyReport.h"

@implementation WeatherController

@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        requestsInProgress = [NSMutableArray array];
    }
    return self;
}

- (void)getWeatherForLocation:(Location *)location
{
    NSString *url = [NSString stringWithFormat:@"http://api.wunderground.com/api/9b046c5a8b7aa1b5/conditions/hourly/forecast10day/q/%@,%@.json", location.latitude, location.longitude];
    NSLog(@"%@", url);
    HTTPConnection *conn = [[HTTPConnection alloc] init];
    [requestsInProgress addObject:conn];
    conn.delegate = self;
    [conn startWithURL:[NSURL URLWithString:url] userInfo:location];
}

- (void)connection:(HTTPConnection *)connection requestDidSucceed:(NSDictionary *)response userInfo:(id)userInfo
{
    [requestsInProgress removeObject:connection];
    [self parseWeather:response forLocation:(Location *)userInfo];
}

- (void)connection:(HTTPConnection *)connection requestDidFail:(NSError *)error userInfo:(id)userInfo
{
    [requestsInProgress removeObject:connection];
    [self.delegate didRecieveWeatherError:error forLocation:(Location *)userInfo];
}

- (void)cancelAllRequests
{
    [requestsInProgress enumerateObjectsUsingBlock:^(HTTPConnection *conn, NSUInteger idx, BOOL *stop) {
        [requestsInProgress removeObjectAtIndex:idx];
        [conn cancel];
    }];
}

- (void)parseWeather:(NSDictionary *)weather forLocation:(Location *)location
{
    NSLog(@"Parsing");
    
    // response
    NSDictionary *response = [weather objectForKey:@"response"];
    NSLog(@"%@", response);
    
    // error?
    NSDictionary *errorDict = [response objectForKey:@"error"];
    if (errorDict) {
        NSInteger errorCode = 500;
        NSString *errorString = [[response objectForKey:@"error"] objectForKey:@"type"];
        if ([errorString isEqual:@"querynotfound"]) errorCode = 404;
        NSError *error = [NSError errorWithDomain:errorString code:errorCode userInfo:errorDict];
        [self.delegate didRecieveWeatherError:error forLocation:location];
        return;
    }
    
    WeatherReport *report = [WeatherReport report:weather forLocation:location];
    [self.delegate didRecieveWeather:report forLocation:location];
}

@end
