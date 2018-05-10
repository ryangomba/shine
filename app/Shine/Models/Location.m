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
@synthesize uid, listIndex;

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

+ (Location *)locationFromDB:(FMResultSet *)results
{
    Location *location = [Location locationWithCity:[results stringForColumn:@"city"]
                                              state:[results stringForColumn:@"state"]
                                            country:[results stringForColumn:@"country"]
                                           latitude:[NSNumber numberWithDouble:[results doubleForColumn:@"latitude"]]
                                          longitude:[NSNumber numberWithDouble:[results doubleForColumn:@"longitude"]]];
    location.uid = [NSNumber numberWithInt:[results intForColumn:@"id"]];
    location.listIndex = [NSNumber numberWithDouble:[results doubleForColumn:@"list_index"]];
    return location;
}

- (NSString *)displayName
{
    if (self.state) {
        return [NSString stringWithFormat:@"%@, %@", self.city, self.state];
    } else {
        return self.city;
    }
    
}

- (BOOL)isCurrentLocation
{
    return [self.listIndex intValue] == 0;
}

- (NSMutableDictionary *)toDBDict
{
    if (!self.listIndex) return nil;
    
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            self.city, @"city",
            self.state, @"state",
            self.country, @"country",
            self.latitude, @"latitude",
            self.longitude, @"longitude",
            self.listIndex, @"list_index",
            nil];
}

@end
