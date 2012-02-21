//
//  Location.m
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "Location.h"

@implementation Location

@synthesize city, state, country;
@synthesize latitude, longitude;

+ (Location *)locationWithCity:(NSString *)city
                         state:(NSString *)state
                       country:(NSString *)country
                      latitude:(NSNumber *)latitude
                     longitude:(NSNumber *)longitude
{
    Location *location = [[Location alloc] init];
    location.city = city;
    location.state = state;
    location.country = country;
    location.latitude = latitude;
    location.longitude = longitude;
    return location;
}

+ (Location *)locationFromWU:(NSDictionary *)info
{
    return [Location locationWithCity:[info objectForKey:@"city"]
                                state:[info objectForKey:@"state"]
                              country:[info objectForKey:@"country_iso3166"]
                             latitude:[NSNumber numberWithFloat:[[info objectForKey:@"latitude"] floatValue]]
                            longitude:[NSNumber numberWithFloat:[[info objectForKey:@"longitude"] floatValue]]];
}

- (NSString *)name
{
    return [NSString stringWithFormat:@"%@, %@", self.city, self.state];
}

@end
