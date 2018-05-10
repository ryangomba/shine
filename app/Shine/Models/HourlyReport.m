//
//  HourlyReport.m
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "WeatherReport.h"
#import "HourlyReport.h"

@implementation HourlyReport

@synthesize day, hour;
@synthesize condition;
@synthesize temp, dewpoint;
@synthesize feelsLike, windChill, heatIndex;
@synthesize humidity;
@synthesize windSpeed, windDirection;
@synthesize amountPre, percentPre, amountSnow;

+ (HourlyReport *)report:(NSDictionary *)info
{
    HourlyReport *report = [[HourlyReport alloc] init];
    
    // time
    report.day = [[info objectForKey:@"FCTTIME"] objectForKey:@"weekday_name"];
    report.hour = [NSNumber numberWithString:[[info objectForKey:@"FCTTIME"] objectForKey:@"hour"]];
    
    // condition
    report.condition = [info objectForKey:@"icon"];
    
    // temperatures
    report.temp = [NSNumber numberWithString:[[info objectForKey:@"temp"] objectForKey:@"english"]];
    report.dewpoint = [NSNumber numberWithString:[[info objectForKey:@"dewpoint"] objectForKey:@"english"]];
    
    // feels like
    report.feelsLike = [NSNumber numberWithString:[[info objectForKey:@"feelslike"] objectForKey:@"english"]];
    report.windChill = [NSNumber numberWithString:[[info objectForKey:@"windchill"] objectForKey:@"english"]];
    report.heatIndex = [NSNumber numberWithString:[[info objectForKey:@"heatindex"] objectForKey:@"english"]];
    
    // wind
    report.windSpeed = [NSNumber numberWithString:[[info objectForKey:@"wspd"] objectForKey:@"english"]];
    report.windDirection = [[info objectForKey:@"wdir"] objectForKey:@"dir"];
    
    // precipitation
    report.amountPre = [NSNumber numberWithString:[[info objectForKey:@"qpf"] objectForKey:@"english"]];
    report.percentPre = [NSNumber numberWithString:[info objectForKey:@"pop"]];
    report.amountSnow = [NSNumber numberWithString:[[info objectForKey:@"snow"] objectForKey:@"english"]];
    
    // humidity
    report.humidity = [NSNumber numberWithString:[info objectForKey:@"humidity"]];
    
    return report;
}

#pragma mark - Accesors

- (NSString *)displayDay
{
    return self.day;
}

- (NSString *)displayHour
{
    return [self.hour hourValue];
}

- (UIImage *)displayCondition
{
    return [WeatherReport iconForCondition:self.condition
                                      hour:[self.hour intValue]];
}

- (NSString *)displayTemp
{
    return [[self.temp checkTempUnits] intStringValue];
}

- (NSString *)displayWindSpeed
{
    return [[self.windSpeed checkWindUnits] intStringValue];
}

- (NSString *)displayPop
{
    return [[self.percentPre intStringValue] stringByAppendingString:@"%"];
}

@end
