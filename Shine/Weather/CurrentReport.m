//
//  HourlyReport.m
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "WeatherReport.h"
#import "CurrentReport.h"

@implementation CurrentReport

@synthesize date;
@synthesize condition;
@synthesize temp, dewpoint;
@synthesize feelsLike, windChill, heatIndex;
@synthesize windSpeed, windDirection;
@synthesize amountPre;
@synthesize relHumidity;

+ (CurrentReport *)report:(NSDictionary *)info
{
    CurrentReport *report = [[CurrentReport alloc] init];
    
    // date
    NSDateFormatter *formatter = [Constructor rfc822Formatter];
    report.date = [formatter dateFromString:[info objectForKey:@"local_time_rfc822"]];
    NSLog(@"%@", report.date);
    
    // condition
    report.condition = [info objectForKey:@"icon"];
    
    // temperatures
    report.temp = [NSNumber numberWithString:[info objectForKey:@"temp_f"]];
    report.dewpoint = [NSNumber numberWithString:[info objectForKey:@"dewpoint_f"]];
    
    // feels like
    report.feelsLike = nil;
    report.windChill = [NSNumber numberWithString:[info objectForKey:@"windchill_f"]];
    report.heatIndex = [NSNumber numberWithString:[info objectForKey:@"heat_index_f"]];
    
    // wind
    report.windSpeed = [NSNumber numberWithString:[info objectForKey:@"wind_mph"]];
    report.windDirection = [info objectForKey:@"wind_dir"];
    
    // precipitation
    report.amountPre = [NSNumber numberWithString:[info objectForKey:@"precip_today_in"]];
    
    // humidity
    report.relHumidity = [NSNumber numberWithString:[info objectForKey:@"relative_humidity"]];
    
    return report;
}

#pragma mark - Displays

- (UIImage *)displayCondition
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit) fromDate:self.date];
    NSInteger hour = [components hour];
    return [WeatherReport iconForCondition:self.condition
                                      hour:hour];
}

- (NSString *)displayTemp
{
    return [[self.temp checkTempUnits] intStringValue];
}

- (NSString *)displayWindSpeed
{
    return [[self.windSpeed checkWindUnits] intStringValue];
}

@end
