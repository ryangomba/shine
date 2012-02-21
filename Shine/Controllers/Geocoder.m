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

- (id)init
{
    self = [super init];
    if (self) {
        receivedData = [NSMutableData data];
    }
    return self;
}

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
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSLog(@"Sending the geocode request...");
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [conn start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"response");
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"data");
    [receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"finished");
    JSONDecoder *decoder = [JSONDecoder decoder];
    NSDictionary *content = [decoder objectWithData:receivedData];
    if (content) {
        NSLog(@"GOT IT");
        [self parseResponse:content];
    } else {
        NSLog(@"Error deconding JSON");
    }
}

# pragma mark -
# pragma mark Parser

- (void)parseResponse:(NSDictionary *)response
{    
    NSArray *results = [response objectForKey:@"results"];
    if (results.count == 0) [self.delegate didGeocodeLocation:nil];
    
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
            city = [comp objectForKey:@"short_name"];
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
    [self.delegate didGeocodeLocation:location];
}

@end
