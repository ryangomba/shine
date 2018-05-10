//
//  Geocoder.m
//  Shine
//
//  Created by Ryan Gomba on 5/20/11.
//  Copyright 2011 AppThat. All rights reserved.
//

#import "Geocoder.h"

@implementation Geocoder

@synthesize delegate;

# pragma mark -
# pragma mark Actions

- (void)locationForSearchString:(NSString *)address
{
    NSLog(@"Geocoding %@", address);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=false",
                                       [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [self locationForURL:url];
}

- (void)locationForLat:(float)lat lon:(float)lon
{
    NSLog(@"Geocoding %f, %f", lat, lon);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%f,%f&sensor=false",
                                       lat, lon]];
    [self locationForURL:url];
}

# pragma mark -
# pragma mark Request

- (void)locationForURL:(NSURL *)url
{
    NSLog(@"%@", url);
    HTTPConnection *conn = [[HTTPConnection alloc] init];
    conn.delegate = self;
    [conn startWithURL:url userInfo:nil];
}

- (void)connection:(HTTPConnection *)connection requestDidSucceed:(NSDictionary *)response userInfo:(id)userInfo
{
    NSLog(@"Geocode request succeeded");
    [self parseResponse:response];
}

- (void)connection:(HTTPConnection *)connection requestDidFail:(NSError *)error userInfo:(id)userInfo
{
    NSLog(@"Geocode request failed");
    [self.delegate geocoderReturnedLocation:nil];
}

# pragma mark -
# pragma mark Parser

- (void)parseResponse:(NSDictionary *)response
{
    NSLog(@"Parsing");
    NSArray *results = [response objectForKey:@"results"];
    if (results.count == 0) [self.delegate geocoderReturnedLocation:nil];
    else NSLog(@"got a result");
    
    NSDictionary *result = [results objectAtIndex:0];
    NSDictionary *coordinates = [[result objectForKey:@"geometry"] objectForKey:@"location"];
    NSNumber *lat = [coordinates objectForKey:@"lat"];
    NSNumber *lon = [coordinates objectForKey:@"lng"];
    NSArray *components = [result objectForKey:@"address_components"];
    __block NSString *city = @"";
    __block NSString *state = @"";
    __block NSString *country = @"";
    [components enumerateObjectsUsingBlock:^(NSDictionary *comp, NSUInteger idx, BOOL *stop) {
        NSArray *types = [comp objectForKey:@"types"];
        if ([types containsObject:@"locality"]) {
            city = [comp objectForKey:@"long_name"];
        } else if ([types containsObject:@"administrative_area_level_1"]) {
            state = [comp objectForKey:@"short_name"];
        } else if ([types containsObject:@"country"]) {
            country = [comp objectForKey:@"short_name"];
        }
    }];
    Location *location = [Location locationWithCity:city
                                              state:state
                                            country:country
                                           latitude:lat
                                          longitude:lon];
    [self.delegate geocoderReturnedLocation:location];
}

@end
