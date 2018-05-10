//
//  Geocoder.h
//  Shine
//
//  Created by Ryan Gomba on 5/20/11.
//  Copyright 2011 AppThat. All rights reserved.
//

#import "HTTPConnection.h"
#import "Location.h"

@protocol ShineGeocoderDelegate
- (void)geocoderReturnedLocation:(Location *)location;
@end

@interface Geocoder : NSObject <HTTPConnectionDelegate>

@property (weak, nonatomic) id <ShineGeocoderDelegate> delegate;

- (void)locationForSearchString:(NSString *)address;

- (void)locationForLat:(float)lat lon:(float)lon;

- (void)locationForURL:(NSURL *)url;

- (void)parseResponse:(NSDictionary *)response; 

@end