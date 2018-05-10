//
//  VerticalScrollView.h
//  Shine
//
//  Created by Ryan Gomba on 2/20/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "CurrentView.h"
#import "DaysView.h"
#import "HoursViewController.h"

#import "WeatherReport.h"

@interface WeatherView : UIScrollView <HoursViewControllerDelegate> {
    CurrentView *currentWeather;
    DaysView *dailyWeather;
    HoursViewController *hourlyWeather;
}

- (void)update:(WeatherReport *)info;

- (void)callHourly;
- (void)dismissHourly;

@end
