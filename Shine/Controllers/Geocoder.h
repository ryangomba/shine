//
//  Geocoder.h
//  Shine
//
//  Created by Ryan Gomba on 5/20/11.
//  Copyright 2011 AppThat. All rights reserved.
//

#import "Location.h"
#import "JSONKit.h"

@protocol GeocoderDelegate
- (void)didGeocodeLocation:(Location *)location;
@end

@interface Geocoder : NSObject <NSURLConnectionDataDelegate> {
    NSMutableData *receivedData;
}

@property (weak, nonatomic) id <GeocoderDelegate> delegate;

- (void)locationForSearchString:(NSString *)address;

- (void)locationForLat:(float)lat lon:(float)lon;

- (void)locationForURL:(NSURL *)url;

- (void)parseResponse:(NSDictionary *)response; 

@end