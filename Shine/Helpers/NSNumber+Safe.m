//
//  NSNumber+Safe.m
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "NSNumber+Safe.h"

@implementation NSNumber (Safe)

+ (NSNumber *)numberWithString:(NSObject *)object
{
    if ([object isKindOfClass:[NSNumber class]]) {
        // NSLog(@"Already a number");
        return (NSNumber *)object;
    }
    else if (![object isKindOfClass:[NSString class]]) {
        // NSLog(@"Not a string");
        return nil;
    }
    NSString *string = (NSString *)object;
    
    // NSLog(@"STR: %@", string);
    
    if ([string isEqual:@"NA"] || [string isEqual:@""]) {
        // NSLog(@"NUM: N/A");
        return nil;
    }
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[-+]?([0-9])*\\.?([0-9]*)"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSRange rangeOfFirstMatch = [regex rangeOfFirstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    if (!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0))) {
        NSString *numberString = [string substringWithRange:rangeOfFirstMatch];
        NSNumber *number = [NSNumber numberWithFloat:[numberString floatValue]];
        // NSLog(@"NUM: %@", number);
        return number;
    }
    // NSLog(@"No matches!");
    return nil;
}

- (NSString *)hourValue
{
    int hour = [self intValue];
    BOOL miitary = [[[NSUserDefaults standardUserDefaults] objectForKey:@"use24hr"] boolValue];
    if (miitary) {
        return [NSString stringWithFormat:@"%02d:00", hour];
    }
    if (hour == 0) return @"12 AM";
    else if (hour < 12) return [NSString stringWithFormat:@"%d AM", hour];
    else if (hour == 12) return @"12 PM";
    return [NSString stringWithFormat:@"%d PM", hour - 12];
}

- (NSNumber *)checkTempUnits
{
    BOOL metric = [[[NSUserDefaults standardUserDefaults] objectForKey:@"useMetric"] boolValue];
    if (metric) {
        float celcius = ([self floatValue] - 32.0) * 5.0 / 9.0;
        return [NSNumber numberWithFloat:celcius];
    }
    return self;
}

- (NSNumber *)checkWindUnits
{
    BOOL metric = [[[NSUserDefaults standardUserDefaults] objectForKey:@"useMetricForWind"] boolValue];
    if (metric) {
        float kph = [self floatValue] * 1.609344;
        return [NSNumber numberWithFloat:kph];
    }
    return self;
}

- (NSString *)intStringValue
{
    return [NSString stringWithFormat:@"%d", [self intValue]];
}

@end
