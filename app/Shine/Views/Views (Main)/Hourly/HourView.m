//
//  HourViewController.m
//  Shine
//
//  Created by Ryan Gomba on 2/20/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "HourView.h"

@implementation HourView

#pragma mark - Properties

+ (NSInteger)height
{
    return 62;
}

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
    hourLabel.text = nil;
    conditionIcon.image = nil;
    tempLabel.text = nil;
    popLabel.text = nil;
    windSpeedLabel.text = nil;
    windUnitLabel.text = nil;
}

- (void)update:(HourlyReport *)hourlyReport
{
    //NSLog(@"Updating hour");
    hourLabel.text = hourlyReport.displayHour;
    conditionIcon.image = hourlyReport.displayCondition;
    tempLabel.text = hourlyReport.displayTemp;
    popLabel.text = hourlyReport.displayPop;
    windSpeedLabel.text = hourlyReport.displayWindSpeed;
    windUnitLabel.text = [WeatherReport windUnit];
}

@end
