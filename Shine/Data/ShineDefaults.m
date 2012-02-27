//
//  ShineDefaults.m
//  Shine
//
//  Created by Ryan Gomba on 2/24/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "ShineDefaults.h"

@implementation ShineDefaults

SINGLETON(ShineDefaults);

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self) {
        //
    }
    return self;
}

#pragma mark - Generic Getter/Setter

+ (id)objectForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)setObject:(id)object forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
}

#pragma mark - Properties

- (NSString *)deviceToken
{
    return [ShineDefaults objectForKey:@"deviceToken"];
}

- (void)setDeviceToken:(NSString *)deviceToken
{
    return [ShineDefaults setObject:deviceToken forKey:@"deviceToken"];
}

- (NSNumber *)selectedLocation
{
    return [ShineDefaults objectForKey:@"selectedLocation"];
}

- (void)setSelectedLocation:(NSNumber *)selectedLocation
{
    return [ShineDefaults setObject:selectedLocation forKey:@"selectedLocation"];
}

- (NSNumber *)badgedLocation
{
    return [ShineDefaults objectForKey:@"badgedLocation"];
}

- (void)setBadgedLocation:(NSNumber *)badgedLocation
{
    return [ShineDefaults setObject:badgedLocation forKey:@"badgedLocation"];
}

- (BOOL)metricTemp
{
    return [[ShineDefaults objectForKey:@"useMetric"] boolValue];
}

- (void)setMetricTemp:(BOOL)metricTemp
{
    return [ShineDefaults setObject:[NSNumber numberWithBool:metricTemp] forKey:@"useMetric"];
}

- (BOOL)metricWind
{
    return [[ShineDefaults objectForKey:@"useMetricForWind"] boolValue];
}

- (void)setMetricWind:(BOOL)metricWind
{
    return [ShineDefaults setObject:[NSNumber numberWithBool:metricWind] forKey:@"useMetricForWind"];
}

- (BOOL)militaryClock
{
    return [[ShineDefaults objectForKey:@"use24hr"] boolValue];
}

- (void)setMilitaryClock:(BOOL)militaryClock
{
    return [ShineDefaults setObject:[NSNumber numberWithBool:militaryClock] forKey:@"use24hr"];
}

@end
