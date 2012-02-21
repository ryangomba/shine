//
//  DailyReport.m
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "DailyReport.h"

@implementation DailyReport

@synthesize day;
@synthesize condition;
@synthesize minTemp, maxTemp;
@synthesize windSpeed, windDirection;
@synthesize amountPre, percentPre, amountSnow;
@synthesize humidity;

+ (DailyReport *)report:(NSDictionary *)info
{
    DailyReport *report = [[DailyReport alloc] init];
    
    // day
    report.day = [[info objectForKey:@"date"] objectForKey:@"weekday"];
    
    // condition
    report.condition = [info objectForKey:@"skyicon"];
    
    // temperature
    report.minTemp = [NSNumber numberWithString:[[info objectForKey:@"low"] objectForKey:@"fahrenheit"]];
    report.maxTemp = [NSNumber numberWithString:[[info objectForKey:@"high"] objectForKey:@"fahrenheit"]];
    
    // wind
    report.windSpeed = [NSNumber numberWithString:[[info objectForKey:@"avewind"] objectForKey:@"mph"]];
    report.windDirection = [[info objectForKey:@"avewind"] objectForKey:@"dir"];
    
    // precipitation
    report.percentPre = [NSNumber numberWithString:[info objectForKey:@"pop"]];
    report.amountPre = [NSNumber numberWithString:[[info objectForKey:@"qpf_allday"] objectForKey:@"in"]];
    report.amountSnow = [NSNumber numberWithString:[[info objectForKey:@"snow_allday"] objectForKey:@"in"]];
    
    // humidity
    report.humidity = [NSNumber numberWithString:[info objectForKey:@"avehumidity"]];
    
    return report;
}

#pragma mark - Displays

- (NSString *)displayDay
{
    return [[self.day substringToIndex:3] uppercaseString];
}

- (UIImage *)displayCondition
{
    return [WeatherReport iconForCondition:self.condition
                                      hour:12];
}

- (NSString *)displayMinTemp
{
    return [[self.minTemp checkTempUnits] intStringValue];
}

- (NSString *)displayMaxTemp
{
    return [[self.maxTemp checkTempUnits] intStringValue];
}

- (NSString *)displayPop
{
    return [[self.percentPre intStringValue] stringByAppendingString:@"%"];
}

@end
