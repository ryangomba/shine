//
//  WeatherController.h
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "HTTPConnection.h"
#import "WeatherReport.h"

@protocol WeatherControllerDelegate
- (void)didRecieveWeather:(WeatherReport *)weather forLocation:(Location *)location;
- (void)didRecieveWeatherError:(NSError *)error forLocation:(Location *)location;
@end

@interface WeatherController : NSObject <HTTPConnectionDelegate> {
    NSMutableArray *requestsInProgress;
}

@property (weak, nonatomic) id <WeatherControllerDelegate> delegate;

- (void)getWeatherForLocation:(Location *)location;
- (void)parseWeather:(NSDictionary *)weather forLocation:(Location *)location;

- (void)cancelAllRequests;

@end
