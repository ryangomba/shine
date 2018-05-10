//
//  CurrentWeatherView.m
//  Shine
//
//  Created by Ryan Gomba on 2/20/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "CurrentView.h"

@implementation CurrentView

#pragma mark - View setup

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // custom
    }
    return self;
}

- (void)awakeFromNib
{
    [self clear];
}

#pragma mark - View generation

- (void)clear
{
    conditionIcon.image = nil;
    tempLabel.text = nil;
    windSpeedLabel.text = nil;
    windUnitLabel.text = nil;
    windDirectionLabel.text = nil;
}

- (void)update:(CurrentReport *)currentReport
{
    NSLog(@"Updating current weather");
    conditionIcon.image = currentReport.displayCondition;
    tempLabel.text = currentReport.displayTemp;
    windSpeedLabel.text = currentReport.displayWindSpeed;
    windUnitLabel.text = [WeatherReport windUnit];
    windDirectionLabel.text = currentReport.displayWindDirection;
}

@end
