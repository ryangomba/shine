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
        [dailyWeather shiftRight:0.0 down:0.0];
        [self addSubview:dailyWeather];
        
        UIImageView *upperShadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"upper-shadow"]];
        [upperShadow shiftRight:0.0 down:(372.0 - upperShadow.frame.size.height)];
        [self addSubview:upperShadow];
        
        hourlyWeather = [[HoursViewController alloc] initWithNibName:@"HoursView" bundle:nil];
        [hourlyWeather.view shiftRight:0.0 down:372.0];
        hourlyWeather.delegate = self;
        [self addSubview:hourlyWeather.view];
        
        currentWeather = [Constructor viewNamed:@"CurrentView" owner:self];
        [currentWeather shiftRight:0.0 down:-77.0];
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
    [hourlyWeather update:info];
}

- (void)hoursViewControllerDidDemandContext
{
    [self setContentOffset:CGPointMake(0.0, 372.0) animated:YES];
}

- (void)callHourly
{
    [hourlyWeather reswitch];
}

- (void)dismissHourly
{
    [hourlyWeather switched:nil];
}

@end
