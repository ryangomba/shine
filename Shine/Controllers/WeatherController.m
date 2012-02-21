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
#import "JSONKit.h"

@implementation WeatherController

@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        receivedData = [NSMutableData data];
    }
    return self;
}

- (void)getWeather
{
    NSString *url = @"http://api.wunderground.com/api/9b046c5a8b7aa1b5/conditions/hourly/forecast10day/q/12533.json";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSLog(@"Sending the request...");
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [conn start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"response");
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
    JSONDecoder *decoder = [JSONDecoder decoder];
    NSDictionary *content = [decoder objectWithData:receivedData];
    if (content) {
        NSLog(@"GOT IT");
        [self parseWeather:content];
    } else {
        NSLog(@"Error deconding JSON");
    }
}

- (void)parseWeather:(NSDictionary *)weather
{
    NSLog(@"Parsing");
    
    // response
    NSDictionary *response = [weather objectForKey:@"response"];
    NSLog(@"%@", response);
    
    // current
    NSDictionary *currentForecast = [weather objectForKey:@"current_observation"];
    CurrentReport *current = [CurrentReport report:currentForecast];
    
    // location
    NSDictionary *locationDict = [currentForecast objectForKey:@"display_location"];
    Location *location = [Location locationFromWU:locationDict];
    
    // daily
    NSDictionary *dailyForecasts = [weather objectForKey:@"forecast"];
    NSArray *dailyForecast = [[dailyForecasts objectForKey:@"simpleforecast"] objectForKey:@"forecastday"];
    //NSArray *dailyTextForecast = [[dailyForecasts objectForKey:@"txt_forecast"] objectForKey:@"forecastday"];
    int numDays = dailyForecast.count;
    NSMutableArray *daily = [NSMutableArray arrayWithCapacity:numDays];
    for (int i=0; i<numDays; i++) {
        [daily addObject:[DailyReport report:[dailyForecast objectAtIndex:i]]];
    }
    
    // hourly
    NSArray *hourlyForecast = [weather objectForKey:@"hourly_forecast"];
    NSMutableArray *hourly = [NSMutableArray array];
    NSString *lastDay = @"Bestday";
    for (int i=0; i<96; i++) {
        HourlyReport *hour = [HourlyReport report:[hourlyForecast objectAtIndex:i]];
        if (![hour.day isEqual:lastDay]) {
            [hourly addObject:[NSMutableArray array]];
            lastDay = hour.day;
        }
        [[hourly lastObject] addObject:hour];
    }
    
    WeatherReport *report = [[WeatherReport alloc] init];
    report.location = location;
    report.current = current;
    report.days = daily;
    report.hours = hourly;
    [self.delegate didRecieveWeather:report];
}

@end
