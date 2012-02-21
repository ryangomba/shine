//
//  VerticalScrollView.m
//  Shine
//
//  Created by Ryan Gomba on 2/20/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "WeatherView.h"

@implementation WeatherView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        dailyWeather = [Constructor viewNamed:@"DaysView" owner:self];
        [dailyWeather shiftRight:0.0 down:44.0];
        [self addSubview:dailyWeather];
        
        hourlyWeather = [[HoursViewController alloc] initWithNibName:@"HoursView" bundle:nil];
        [hourlyWeather.view shiftRight:0.0 down:436.0];
        [self addSubview:hourlyWeather.view];
        
        currentWeather = [Constructor viewNamed:@"CurrentView" owner:self];
        [self addSubview:currentWeather];
        
        [self setContentSize:CGSizeMake(320.0, 2 * 416.0)];
        [self setShowsVerticalScrollIndicator:NO];
        [self setPagingEnabled:YES];
        
    }
    return self;
}

- (void)update:(WeatherReport *)info
{
    NSLog(@"Updating weather UI");
    [currentWeather update:info.current];
    [dailyWeather update:info.days];
    [hourlyWeather update:info.hours];
}

@end
