//
//  WeatherReport.m
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "WeatherReport.h"

@implementation WeatherReport

@synthesize location, current, hours, days, text;

+ (WeatherReport *)report:(NSDictionary *)info
              forLocation:(Location *)location
{
    // current
    NSDictionary *currentForecast = [info objectForKey:@"current_observation"];
    CurrentReport *current = [CurrentReport report:currentForecast];
    
    // location
    if (!location) {
        NSDictionary *locationDict = [currentForecast objectForKey:@"display_location"];
        location = [Location locationFromWU:locationDict];
    }
    
    // daily
    NSDictionary *dailyForecasts = [info objectForKey:@"forecast"];
    NSArray *dailyForecast = [[dailyForecasts objectForKey:@"simpleforecast"] objectForKey:@"forecastday"];
    //NSArray *dailyTextForecast = [[dailyForecasts objectForKey:@"txt_forecast"] objectForKey:@"forecastday"];
    int numDays = dailyForecast.count;
    NSMutableArray *daily = [NSMutableArray arrayWithCapacity:numDays];
    for (int i=0; i<numDays; i++) {
        [daily addObject:[DailyReport report:[dailyForecast objectAtIndex:i]]];
    }
    
    // hourly
    NSArray *hourlyForecast = [info objectForKey:@"hourly_forecast"];
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
    
    // text
    NSArray *textForecast = [[dailyForecasts objectForKey:@"txt_forecast"] objectForKey:@"forecastday"];
    NSMutableArray *texts = [NSMutableArray array];
    [textForecast enumerateObjectsUsingBlock:^(NSDictionary *textDict, NSUInteger i, BOOL *stop) {
        TextReport *text = [TextReport report:textDict];
        [texts addObject:text];
        if (i > 12) *stop = YES;
    }];
    
    WeatherReport *report = [[WeatherReport alloc] init];
    report.location = location;
    report.current = current;
    report.days = daily;
    report.hours = hourly;
    report.text = texts;
    return report;
}

+ (NSString *)windUnit
{
    BOOL metric = [ShineDefaults shared].metricWind;
    if (metric) return @"KPH";
    return @"MPH";
}

+ (UIImage *)iconForCondition:(NSString *)condition
                         hour:(NSInteger)hour
{   
    NSString *iconName;
    if ([condition isEqual:@"mostlysunny"]) iconName = @"partlycloudy";
    else if ([condition isEqual:@"partlysunny"]) iconName = @"mostlycloudy";
    else if ([condition isEqual:@"sunny"]) iconName = @"clear";
    else iconName = condition;
    
    NSString *prefix = @"day-";
    if (hour < 6 || hour > 18) prefix = @"night-";
    
    return [UIImage imageNamed:[prefix stringByAppendingString:iconName]];
}

@end
