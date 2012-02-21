//
//  DailyWeatherView.m
//  Shine
//
//  Created by Ryan Gomba on 2/20/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "DayView.h"

@implementation DayView

#pragma mark - Properties

+ (NSInteger)width
{
    return 108;
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
    dayLabel.text = nil;
    conditionIcon.image = nil;
    minTempLabel.text = nil;
    maxTempLabel.text = nil;
    popLabel.text = nil;
}

- (void)update:(DailyReport *)info
{
    NSLog(@"Updating day");
    dayLabel.text = info.displayDay;
    conditionIcon.image = info.displayCondition;
    minTempLabel.text = info.displayMinTemp;
    maxTempLabel.text = info.displayMaxTemp;
    popLabel.text = info.displayPop;
}

@end
