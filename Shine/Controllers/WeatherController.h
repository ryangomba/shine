//
//  WeatherController.h
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "WeatherReport.h"

@protocol WeatherControllerDelegate
- (void)didRecieveWeather:(WeatherReport *)weather;
@end

@interface WeatherController : NSObject <NSURLConnectionDataDelegate> {
    NSMutableData *receivedData;
}

@property (weak, nonatomic) id <WeatherControllerDelegate> delegate;

- (void)getWeather;
- (void)parseWeather:(NSDictionary *)weather;

@end
