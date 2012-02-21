//
//  WeatherReport.m
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "WeatherReport.h"

@implementation WeatherReport

@synthesize location, current, hours, days;

+ (NSString *)windUnit
{
    BOOL metric = [[[NSUserDefaults standardUserDefaults] objectForKey:@"useMetricForWind"] boolValue];
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
