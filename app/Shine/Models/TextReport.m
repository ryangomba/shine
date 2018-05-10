//
//  TextReport.m
//  Shine
//
//  Created by Ryan Gomba on 2/23/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "TextReport.h"

#import "WeatherReport.h"

@implementation TextReport

@synthesize title, condition, usDescription, metricDescription;

#pragma mark - Constructors

+ (TextReport *)report:(NSDictionary *)info
{
    TextReport *report = [[TextReport alloc] init];
    
    report.title = [info objectForKey:@"title"];
    report.condition = [info objectForKey:@"icon"];
    report.usDescription = [info objectForKey:@"fcttext"];
    report.metricDescription = [info objectForKey:@"fcttext_metric"];
    
    return report;
}

#pragma mark - Accessors

- (NSString *)displayTitle
{
    return [title capitalizedString];
}

- (UIImage *)displayCondition
{
    int hour = 0;
    if ([[self.title lowercaseString] rangeOfString:@"night"].location == NSNotFound) {
        hour = 12;
    }
    return [WeatherReport iconForCondition:self.condition
                                      hour:hour];
}

- (NSString *)displayDescription
{
    BOOL metric = [ShineDefaults shared].metricTemp;
    if (metric) return self.metricDescription;
    return self.usDescription;
}

@end
